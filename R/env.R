#' get an envrionment variable `HEADLESS_CHROME`
#'
#' @md
#' @note This only return an envrionment variable `HEADLESS_CHROME`.
#' @export
#' @examples
#' get_env()
get_env <- function() {
  Sys.getenv("HEADLESS_CHROME")
}

#' set an envrionment variable `HEADLESS_CHROME`
#'
#' @md
#' @note This only grabs the `<body>` `innerHTML` contents
#' @param env path of chrome execute file for an envrionment variable `HEADLESS_CHROME`
#' @export
#' @examples
#' set_env("C:/Program Files/Google/Chrome/Application/chrome.exe")
set_env <- function(env=Sys.getenv("HEADLESS_CHROME")) {
  Sys.setenv(HEADLESS_CHROME=env)
}