#' Get token by login to Ecotopia
#' Config should be set in config file.
#' File path is in the working directory and named as 'ecotopia.yml'.
#' ecotopia.yml example:
#' domain: domain_name
#' username: user_name
#' password: pass_word
#' token: token_string
#' token is optional
#' if token is provided, this function will return the token directly.
#' @return A character string of the token for API calling.
#' @export
#'
#' @examples
#' token <- ecotopia_user_token()
ecotopia_user_token <- function() {
  return(ecotopia_utils_token())
}
