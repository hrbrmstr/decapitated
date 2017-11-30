#' Get Chrome version
#'
#' @md
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @export
#' @examples
#' chrome_version()
chrome_version <- function(chrome_bin=Sys.getenv("HEADLESS_CHROME")) {
  system2(chrome_bin, "--version")
}