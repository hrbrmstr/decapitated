#' Get Chrome version
#'
#' @md
#' @param quiet if `TRUE`, no messages are displayed
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @return the Chrome version string (invisibly)
#' @export
#' @examples
#' chrome_version()
chrome_version <- function(quiet = FALSE, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {
  res <- processx::run(chrome_bin, "--version")
  if (!quiet) message(res$stdout)
  return(invisible(trimws(res$stdout)))
}