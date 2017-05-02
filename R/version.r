#' Get Chrome version
#'
#' @export
chrome_version <- function(x) { system2(chrome_bin, "--version") }