#' Get Chrome version
#'
#' @md
#' @export
#' @examples
#' chrome_version()
chrome_version <- function() {
  system2(chrome_bin, "--version")
}