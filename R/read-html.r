#' Read a URL via headless Chrome and return the raw or rendered `<body>` `innerHTML` DOM elements
#'
#' @md
#' @note This only grabs the `<body>` `innerHTML` contents
#' @param url URL to read from
#' @param render if `TRUE` then return an `xml_document`, else the raw HTML (invisibly)
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @export
#' @examples
#' chrome_read_html("https://www.r-project.org/")
chrome_read_html <- function(url, render=TRUE, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  args <- c("--headless")
  args <- c(args, "--disable-gpu")
  args <- c(args, "--no-sandbox")
  args <- c(args, "--allow-no-sandbox-job")
  args <- c(args, sprintf("--user-data-dir=%s", .get_app_dir()))
  args <- c(args, sprintf("--crash-dumps-dir=%s", .get_app_dir()))
  args <- c(args, sprintf("--utility-allowed-dir=%s", .get_app_dir()))
  args <- c(args, "--dump-dom", url)

  processx::run(
    command = chrome_bin,
    args = args,
    error_on_status = FALSE,
    echo_cmd = FALSE,
    echo = FALSE
  ) -> res

  if (render) xml2::read_html(res$stdout) else return(invisible(res$stdout))

}
