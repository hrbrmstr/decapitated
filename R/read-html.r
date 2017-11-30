#' Read a URL via headless Chrome and return the renderd `<body>` `innerHTML` DOM elements
#'
#' @md
#' @note This only grabs the `<body>` `innerHTML` contents
#' @param url URL to read from
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @export
#' @examples
#' chrome_read_html("https://www.r-project.org/")
chrome_read_html <- function(url, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {
  url <- shQuote(url)
  tmp <- system2(chrome_bin, c("--headless", "--disable-gpu", "--dump-dom", url), stdout=TRUE)
  print(tmp)
  xml2::read_html(tmp)
}

#' "Print" to PDF
#'
#' @md
#' @note this is a quick version of the function and will overwrite `output.pdf` if it exists in CWD
#' @param url URL to read from
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @export
#' @examples
#' chrome_dump_pdf("https://www.r-project.org/")
chrome_dump_pdf <- function(url, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {
  url <- shQuote(url)
  tmp <- system2(chrome_bin, c("--headless", "--disable-gpu", "--print-to-pdf", url))
}

#' Capture a screenshot
#'
#' For the moment, the capture file is in the current working directory and named
#' `screenshot.png`. This will change, soon.
#'
#' A `magick` image object is returned.
#'
#' @md
#' @note this is a quick version of the function and will overwrite `screenshot.png` if it exists in CWD
#' @param url URL to read from
#' @param width,height screen size to emulate
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @return `magick`
#' @export
#' @examples
#' chrome_shot("https://www.r-project.org/logo/Rlogo.svg")
chrome_shot <- function(url, width=NULL, height=NULL, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  args <- c("--headless", "--disable-gpu", "--screenshot")

  url <- shQuote(url)

  if (!is.null(width) & !is.null(height)) {
    args <-  c(args, sprintf("--window-size=%s,%s", height, width))
  }

  args <- c(args, url)

  tmp <- system2(chrome_bin, args)

  magick::image_read("screenshot.png")

}
