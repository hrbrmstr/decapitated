#' Read a URL via headless Chrome and return the raw or rendered `<body>` `innerHTML` DOM elements
#'
#' @section Working around headless Chrome & OS security restrictions:
#' Security restrictions on various operating systems and OS configurations can cause
#' headless Chrome execution to fail. As a result, headless Chrome operations should
#' use a special directory for `decapitated` package operations. You can pass this
#' in as `work_dir`. If `work_dir` is `NULL` a `.rdecapdata` directory will be
#' created in your home directory and used for the data, crash dumps and utility
#' directories for Chrome operations.\cr
#' \cr
#' `tempdir()` does not always meet these requirements (after testing on various
#' macOS 10.13 systems) as Chrome does some interesting attribute setting for
#' some of its file operations.
#' \cr
#' If you pass in a `work_dir`, it must be one that does not violate OS security
#' restrictions or headless Chrome will not function.
#'
#' @md
#' @note This only grabs the `<body>` `innerHTML` contents
#' @param url URL to read from
#' @param render if `TRUE` then return an `xml_document`, else the raw HTML (invisibly)
#' @param prime if `TRUE` preliminary URL retrieval requests will be sent to "prime" the
#'        headless Chrome cache. This seems to be necessary primarily on recent versions of macOS.
#'        If numeric, that number of "prime" requests will be sent ahead of the capture request.
#'        If `FALSE` no priming requests will be sent.
#' @param work_dir See special Section.
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @export
#' @examples
#' chrome_read_html("https://www.r-project.org/")
chrome_read_html <- function(url, render=TRUE, prime=TRUE, work_dir = NULL,
                             chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  work_dir <- if (is.null(work_dir)) .get_app_dir() else work_dir

  args <- c("--headless")
  args <- c(args, "--disable-gpu")
  args <- c(args, "--no-sandbox")
  args <- c(args, "--allow-no-sandbox-job")
  args <- c(args, sprintf("--user-data-dir=%s", work_dir))
  args <- c(args, sprintf("--crash-dumps-dir=%s", work_dir))
  args <- c(args, sprintf("--utility-allowed-dir=%s", work_dir))
  args <- c(args, "--dump-dom", url)

  vers <- chrome_version(quiet=TRUE)

  .prime_url(url, as.numeric(prime), work_dir, chrome_bin)

  processx::run(
    command = chrome_bin,
    args = args,
    error_on_status = FALSE,
    echo_cmd = FALSE,
    echo = FALSE
  ) -> res

  if (render) xml2::read_html(res$stdout) else return(invisible(res$stdout))

}
