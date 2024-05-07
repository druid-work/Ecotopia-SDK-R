test_that("ectopia_data_api", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token()
  expect_no_error(
    ectopia_data_api(
      config,
      "GPS",
      "61c19791da38d267491633d4",
      max_result = 1
    )
  )
})

test_that("ectopia_data_gps_one_device", {
  cat("\nectopia_data_gps_one_device\n")
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ectopia_data_one_device(
      config,
      "GPS",
      device_id = "61c19791da38d267491633d4",
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ecotopia_data_gps_multi_devices", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ecotopia_data_multi_device(
      config,
      "GPS",
      device_ids = c("61c19791da38d267491633d4", "5d550bf8534ed5fb9d36cc98"),
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ectopia_data_env_one_device", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ectopia_data_one_device(
      config,
      "ENV",
      device_id = "61c19791da38d267491633d4",
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ecotopia_data_env_multi_devices", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ecotopia_data_multi_device(
      config,
      "ENV",
      device_ids = c("61c19791da38d267491633d4", "5d550bf8534ed5fb9d36cc98"),
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ectopia_data_odba_one_device", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ectopia_data_one_device(
      config,
      "ODBA",
      device_id = "61c19791da38d267491633d4",
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ecotopia_data_odba_multi_devices", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ecotopia_data_multi_device(
      config,
      "ODBA",
      device_ids = c("61c19791da38d267491633d4", "5d550bf8534ed5fb9d36cc98"),
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ectopia_data_acc_one_device", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ectopia_data_one_device(
      config,
      "ACC",
      device_id = "61c19791da38d267491633d4",
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})

test_that("ecotopia_data_acc_multi_devices", {
  config <- ecotopia_config()
  if (is.null(config)) {
    return()
  }
  config$token <- ecotopia_utils_token(config)
  expect_no_error(
    ecotopia_data_multi_device(
      config,
      "ACC",
      device_ids = c("61c19791da38d267491633d4", "5d550bf8534ed5fb9d36cc98"),
      max_requests_per_device = 2,
      max_results_per_request = 2
    )
  )
})
