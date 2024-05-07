#' Get all ENV data from Ecotopia API
#' @param show_progress Show download progress log
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @param start_time Start time of the data to be downloaded
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @return List of all devices contain list of vectors with their ENV data.
#' @export
#' @examples
#' ecotopia_data_all_env(show_progress = "SIMPLE")
ecotopia_data_all_env <- function(show_progress = "OFF", start_time = NULL) {
  return(ecotopia_data_type_devices(
    "ENV",
    show_progress,
    device_ids = NULL,
    start_time = start_time
  ))
}
