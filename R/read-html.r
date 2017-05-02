#' Read a URL via headless Chrome and return the renderd `<body>` `innerHTML` DOM elements
#'
#' @md
#' @note This only grabs the `<body>` `innerHTML` contents
#' @param url URL to read from
#' @export
#' @examples
#' chrome_read_html("https://www.r-project.org/")
chrome_read_html <- function(url) {
  tmp <- system2(chrome_bin, c("--version", "--headless", "--disable-gpu", "--dump-dom", url), stdout=TRUE)
  xml2::read_html(tmp)
}

#' "Print" to PDF
#'
#' @md
#' @note this is a quick version of the function and will overwrite `output.pdf` if it exists in CWD
#' @param url URL to read from
#' @export
#' @examples
#' chrome_dump_pdf("https://www.r-project.org/")
chrome_dump_pdf <- function(url) {
  tmp <- system2(chrome_bin, c("--version", "--headless", "--disable-gpu", "--print-to-pdf", url))
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
#' @return `magick`
#' @export
#' @examples
#' chrome_shot("https://www.r-project.org/logo/Rlogo.svg")
chrome_shot <- function(url, width=NULL, height=NULL) {

  args <- c("--version", "--headless", "--disable-gpu", "--screenshot")

  if (!is.null(width) & !is.null(height)) {
    args <-  c(args, sprintf("--window-size=%s,%s", height, width))
  }

  args <- c(args, url)

  tmp <- system2(chrome_bin, args)

  magick::image_read("screenshot.png")

}
