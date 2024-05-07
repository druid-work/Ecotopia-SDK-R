#' Get all ACC data from Ecotopia API
#' @param show_progress Show download progress log
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @param start_time Start time of the data to be downloaded
#' @return List of all devices contains a list of vectors with their ACC data.
#' @export
#' @examples
#' ecotopia_data_all_acc()
ecotopia_data_all_acc <- function(show_progress = "OFF", start_time = NULL) {
  return(ecotopia_data_type_devices(
    "ACC",
    show_progress,
    device_ids = NULL,
    start_time = start_time
  ))
}
