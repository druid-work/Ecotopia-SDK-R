#' Get devices' ACC data from Ecotopia API
#' @param device_uuids Device UUIDs to get data from
#' @param show_progress Show download progress log
#' show_progress can be "OFF", "SIMPLE" or "FULL"
#' @param start_time Start time of the data to be downloaded
#' @return List of devices contains a list of vectors with their ACC data.
#' @export
#' @examples
#' ecotopia_data_devices_acc(
#'   c("device_id1", "device_id2", "device_id3"),
#'   show_progress = "SIMPLE"
#' )
ecotopia_data_devices_acc <- function(
  device_uuids, show_progress = "OFF", start_time = NULL
) {
  return(ecotopia_data_type_devices(
    type = "ACC",
    show_progress = show_progress,
    device_ids = device_uuids,
    start_time = start_time
  ))
}
