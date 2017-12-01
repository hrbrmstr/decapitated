#' Capture a screenshot
#'
#' For the moment, the capture file is in the current working directory and named
#' `screenshot.png`. This will change, soon.
#'
#' A `magick` image object is returned.
#'
#' @md
#' @note The default Chrome filename is `screenshot.png`
#' @param url URL to read from
#' @param width,height screen size to emulate
#' @param path path (with optional output filename) for the generated PDF. If `NULL` then
#'        and `overwrite` is `FALSE`, the fuction will will ensure a uniquely-named file is
#'        placed in the current working directory by incrementing trailing numbers before
#'        the end of it.
#' @param overwrite overwrite existing file? Default: `TRUE`
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @return `magick`
#' @export
#' @examples
#' chrome_shot("https://www.r-project.org/logo/Rlogo.svg")
chrome_shot <- function(url, width=NULL, height=NULL, path=NULL, overwrite=TRUE,
                        chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  curwd <- getwd()
  on.exit(setwd(curwd), add = TRUE)

  if (is.null(path)) path <- "."

  path <- normalizePath(path.expand(path[1]))

  if (!grepl("\\.pdf$", path)) {
    fil_nam <- "screenshot.png"
    dir_nam <- path
  } else {
    fil_nam <- basename(path)
    dir_nam <- dirname(path)
  }

  fil_ext <- tools::file_ext(fil_nam)
  fil_pre <- tools::file_path_sans_ext(fil_nam)

  td <- tempdir()

  setwd(td)

  args <- c("--headless")
  args <- c(args, "--disable-gpu")
  args <- c(args, "--no-sandbox")
  args <- c(args, "--allow-no-sandbox-job")
  args <- c(args, sprintf("--user-data-dir=%s", .get_app_dir()))
  args <- c(args, sprintf("--crash-dumps-dir=%s", .get_app_dir()))
  args <- c(args, sprintf("--utility-allowed-dir=%s", .get_app_dir()))
  args <- c(args, "--screenshot", url)

  if (!is.null(width) & !is.null(height)) {
    args <-  c(args, sprintf("--window-size=%s,%s", height, width))
  }

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

  file.copy("screenshot.png", out_fil, overwrite = overwrite)

  if (file.exists(out_fil)) magick::image_read(out_fil)

}
