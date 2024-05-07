#' Get User's Devices table from Ecotopia
#' Config should be set in config file.
#' File path is in the working directory and named as 'ecotopia.yml'.
#' ecotopia.yml example:
#' domain: domain_name
#' username: user_name
#' password: pass_word
#' token: token_string
#' token is optional
#' if token is provided, username and password will be ignored.
#' @param max_devices Limit max count of devices return. default is 1000.
#' @param start_date Require devices start from the specified time.
#'
#' @return A dataframe of devices information.
#' @export
#'
#' @examples
#' devices <- ecotopia_data_devices(
#'   max_devices = 1000,
#'   start_date = "2019-01-01"
#' )
ecotopia_data_devices <- function(max_devices = 1e3,
                                  start_date = NULL) {
  return(
    ecotopia_utils_devices(
      max_devices = max_devices,
      start_date = start_date
    )
  )
}
