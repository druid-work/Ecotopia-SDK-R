#' Get all GPS data from Ecotopia API
#' @param show_progress Show download progress log
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @param start_time Start time of the data to be downloaded
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @return List of all devices contain list of vectors with their GPS data.
#' @export
#' @examples
#' ecotopia_data_all_gps(show_progress = "SIMPLE")
ecotopia_data_all_gps <- function(show_progress = "OFF", start_time = NULL) {
  return(ecotopia_data_type_devices(
    "GPS",
    show_progress,
    device_ids = NULL,
    start_time = start_time
  ))
}
