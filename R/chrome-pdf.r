#' "Print" to PDF
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
#' @note The default Chrome filename is `output.pdf`
#' @param url URL to read from
#' @param path path (with optional output filename) for the generated PDF. If `NULL` then
#'        and `overwrite` is `FALSE`, the fuction will will ensure a uniquely-named file is
#'        placed in the current working directory by incrementing trailing numbers before
#'        the end of it.
#' @param overwrite overwrite existing file? Default: `TRUE`
#' @param prime if `TRUE` preliminary URL retrieval requests will be sent to "prime" the
#'        headless Chrome cache. This seems to be necessary primarily on recent versions of macOS.
#'        If numeric, that number of "prime" requests will be sent ahead of the capture request.
#'        If `FALSE` no priming requests will be sent.
#' @param work_dir See special Section.
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @return output fileame (invisibly)
#' @export
#' @examples
#' chrome_dump_pdf("https://www.r-project.org/")
chrome_dump_pdf <- function(url, path=NULL, overwrite=TRUE, prime=TRUE,
                            work_dir = NULL, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  curwd <- getwd()
  on.exit(setwd(curwd), add = TRUE)

  path <- if (is.null(path)) "." else path[1]

  path <- suppressWarnings(normalizePath(path.expand(path)))

  if (!grepl("\\.pdf$", path)) {
    fil_nam <- "output.pdf"
    dir_nam <- path
  } else {
    fil_nam <- basename(path)
    dir_nam <- dirname(path)
  }

  fil_ext <- tools::file_ext(fil_nam)
  fil_pre <- tools::file_path_sans_ext(fil_nam)

  td <- tempdir()

  setwd(td)

  work_dir <- if (is.null(work_dir)) .get_app_dir() else work_dir

  args <- c("--headless")
  args <- c(args, "--disable-gpu")
  args <- c(args, "--no-sandbox")
  args <- c(args, "--allow-no-sandbox-job")
  args <- c(args, sprintf("--user-data-dir=%s", work_dir))
  args <- c(args, sprintf("--crash-dumps-dir=%s", work_dir))
  args <- c(args, sprintf("--utility-allowed-dir=%s", work_dir))
  args <- c(args, "--print-to-pdf", url)

  vers <- chrome_version(quiet=TRUE)

  .prime_url(url, as.numeric(prime), work_dir, chrome_bin)

  processx::run(
    command = chrome_bin,
    args = args,
    error_on_status = FALSE,
    echo_cmd = FALSE,
    echo = FALSE
  ) -> res

  first_fil <- file.path(dir_nam, sprintf("%s.%s", fil_pre, fil_ext))
  out_fil <- first_fil

  if (!overwrite) {

    moar_fils <- sprintf(file.path(dir_nam, sprintf("%s%%04d.%s", fil_pre, fil_ext)), 0:9999)
    fils <- c(first_fil, moar_fils)

    out_fil <- fils[which(!file.exists(fils))[1]]
    if (is.na(out_fil)) stop("Cannot create unique filename")

  }

  file.copy("output.pdf", out_fil, overwrite = overwrite)

  return(invisible(out_fil))

}