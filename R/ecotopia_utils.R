ecotopia_using <- function(...) {
  libs <- unlist(list(...))
  req <- unlist(lapply(libs, require, character.only = TRUE))
  need <- libs[req == FALSE]
  if (length(need) > 0) {
    utils::install.packages(need)
    lapply(need, require, character.only = TRUE)
  }
}

ecotopia_config <- function(config = NULL) {
  if (is.null(config) || length(config) == 0) {
    if (!file.exists("ecotopia.yml")) {
      warning("Please provide ecotopia.yml at working directory.")
      return(NULL)
    }
    ecotopia_using("yaml")
    config <- yaml::yaml.load_file("ecotopia.yml")
  }
  if (is.null(config$domain)) {
    warning("Please provide domain in ecotopia.yml.")
    return(NULL)
  }
  if (is.null(config$token) || config$token == "") {
    if (is.null(config$username) || is.null(config$password)) {
      warning("Please provide token or username and password in ecotopia.yml.")
      return(NULL)
    }
  }
  return(config)
}

ecotopia_utils_token <- function(config = NULL) {
  ecotopia_using("httr", "jsonlite", "digest")
  config <- ecotopia_config(config)
  if (is.null(config)) {
    return("")
  }
  if (!is.null(config$token) && config$token != "") {
    return(config$token)
  }
  pswhash <- digest::digest(paste0(config$username, " + druid + ",
                                   config$password, " + heifeng"),
                            algo = c("sha256"), serialize = FALSE)
  post_body <- paste0('{"username":"', config$username,
                      '","password":"', pswhash, '"}')
  response <- httr::POST(paste0("https://", config$domain, "/api/v2/login"),
                         body = post_body)
  if (response$status_code != "200") {
    stop(paste0("Login Error, Error Code: ", response$status_code))
  }
  token <- response$headers$`x-druid-authentication`
  return(token)
}

ecotopia_utils_devices <- function(config = NULL, max_devices = 1e3,
                                   start_date = NULL) {
  ecotopia_using("httr", "jsonlite", "data.table")
  config <- ecotopia_config(config)
  if (is.null(config)) {
    return(data.frame())
  }
  config$token <- ecotopia_utils_token(config)
  headers <- httr::add_headers("x-druid-authentication" = config$token,
                               "x-result-limit" = max_devices)
  url <- paste0("https://", config$domain, "/api/v3/device/page/", start_date)
  response <- httr::GET(url, config = headers)
  if (response$status_code != "200") {
    stop(paste0("Request Devices Error, Error Code: ", response$status_code))
  }
  # Transform Devices Data to dataframe
  devices <- data.table::rbindlist(lapply(lapply(httr::content(response),
                                                 unlist), as.list), fill = TRUE)
  devices <- as.data.frame(devices)
  # Translate Devices Status From Numbers
  devices$inventory_status[devices$inventory_status == 10] <- "active"
  devices$inventory_status[devices$inventory_status == 12] <- "suspended"
  # Tranform Time Format for R to Understand
  devices$updated_at <- ecotopia_time_iso_to_r(devices$updated_at)
  return(devices)
}

ecotopia_time_iso_to_r <- function(time) {
  return(gsub("Z", "", gsub("T", " ", time)))
}

ecotopia_time_r_to_iso <- function(time) {
  return(gsub(" ", "T", paste0(time, "Z")))
}

ectopia_data_api <- function(config, type, device_id,
                             max_result = 1e3, start_time = NULL) {
  if (is.null(max_result) || is.na(max_result)) {
    max_result <- 1000
  }
  ecotopia_using("httr")
  type <- switch(type, "GPS" = "gps", "ENV" = "env",
                 "ODBA" = "behavior2", "ACC" = "origin")
  url <- paste0("https://", config$domain, "/api/v2/",
                type, "/device/", device_id, "/page/", start_time)
  headers <- httr::add_headers("x-druid-authentication" = config$token,
                               "x-result-limit" = max_result,
                               "x-result-sort" = "timestamp")
  response <- httr::GET(url, config = headers)
  if (response$status_code != "200") {
    stop(paste0("Request ", type, " Error, Error Code: ", response$status_code))
  }
  result <- httr::content(response, as = "parsed")
  return(result)
}

ectopia_data_one_device <- function(
  config,
  type,
  device_id,
  start_time = NULL,
  max_requests_per_device = NULL,
  max_results_per_request = NULL,
  show_progress = "OFF"
) {
  ecotopia_using("httr", "jsonlite", "data.table")
  if (!is.null(start_time)) {
    start_time <- ecotopia_time_r_to_iso(start_time)
  }
  config$token <- ecotopia_utils_token(config)
  results <- list()
  request_count <- 0
  while (TRUE) {
    data <- ectopia_data_api(config, type, device_id,
      max_result = max_results_per_request,
      start_time = start_time
    )
    if (length(data) == 0) {
      break
    }
    results <- c(results, data)
    start_time <- data[[length(data)]]$timestamp
    if (show_progress == "FULL") {
      cat(length(data), "lines upto", as.character(
        gsub(
          "Z", "", gsub("T", " ", results[[length(results)]]$timestamp)
        )
      ), "\n")
    }
    request_count <- request_count + 1
    if (!is.null(max_requests_per_device)
      && request_count >= max_requests_per_device
    ) {
      break
    }
  }
  if ((show_progress == "FULL" || show_progress == "SIMPLE")
      && length(results) > 0) {
    cat("Total", length(results), "lines upto", as.character(
      gsub(
        "Z", "", gsub("T", " ", results[[length(results)]]$timestamp)
      )
    ) , "\n")
  }
  results <- data.table::rbindlist(lapply(lapply(results,
                                                 unlist), as.list), fill = TRUE)
  results <- as.data.frame(results)
  return(results)
}

ecotopia_data_multi_device <- function(
  config,
  type,
  device_ids,
  start_time = NULL,
  max_devices = NULL,
  max_requests_per_device = NULL,
  max_results_per_request = NULL,
  show_progress = "OFF"
) {
  results <- list()
  device_count <- 1
  for (device_id in device_ids) {
    if (show_progress == "FULL" || show_progress == "SIMPLE") {
      cat("\nDevice", device_count, "-", type, "-", device_id, "\n\n")
    }
    data <- ectopia_data_one_device(
      config, type, device_id, start_time,
      max_requests_per_device, max_results_per_request, show_progress
    )
    results[[device_id]] <- data
    device_count <- device_count + 1
    if (!is.null(max_devices)
      && device_count > max_devices
    ) {
      break
    }
  }
  return(results)
}

ecotopia_data_type_devices <- function(
  type,
  show_progress = "OFF",
  device_ids = NULL,
  start_time = NULL
) {
  config <- ecotopia_config()
  if (is.null(config)) {
    return(list())
  }
  config$token <- ecotopia_utils_token(config)
  if (is.null(device_ids)) {
    devices <- ecotopia_utils_devices(config)
    active_devices <- subset(devices, devices$inventory_status == "active")
    device_ids <- active_devices$id
  }
  data <- ecotopia_data_multi_device(
    config,
    type,
    device_ids = device_ids,
    start_time = start_time,
    show_progress = show_progress
  )
  return(data)
}
