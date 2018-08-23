#' Create a connection to a Gepetto API server
#'
#' @md
#' @param host where is it running? Defaults to "`localhost`"
#' @param port same, but what port? Defaults to `8080` since the most common
#'        use case is that you have `gepetto` running in a Docker container.
#'        Use `3000` if you're running it locally via `npm` as that's the default
#'        port for development.`
#' @return A `gepetto` connection object
#' @export
#' @examples \dontrun{
#' gepetto()
#' }
gepetto <- function(host = "localhost", port = 8080) {

  list(
    host = host,
    port = port
  ) -> out

  class(out) <- c("gepetto")

  out

}

#' Print
#' @md
#' @param x `gepetto` object
#' @param ... unused
#' @keywords internal
#' @export
print.gepetto <- function(x, ...) {
  cat("<gepetto@", x$host, ":", x$port, ">\n", sep="")
}

#' Render a page in a javascript context and serialize to HTML
#'
#' @md
#' @param gep a gepetto connection object
#' @param url the URL to fetch and render
#' @param width,height viewport width/height
#' @return HTML
#' @export
#' @examples \dontrun{
#' gepetto(port=3000) %>%
#'   gep_render_html("https://r-project.org/")
#' }
gep_render_html <- function(gep, url, width=1440, height=5000) {

  httr::GET(
    url = sprintf("http://%s:%s/render_html", gep$host, gep$port),
    query = list(
      url = url,
      width = width,
      height = height
    )

  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- xml2::read_html(out)

  out

}

#' Render a page in a javascript context and serialize to HAR
#'
#' TODO: Modify the `puppeteer-har` node module to allow for saving content
#'
#' @md
#' @param gep a gepetto connection object
#' @param url the URL to fetch and render
#' @param width,height viewport width/height
#' @return HAR
#' @note content is not returned, just HAR information
#' @export
#' @examples \dontrun{
#' gepetto(port=3000) %>%
#'   gep_render_har("https://r-project.org/")
#' }
gep_render_har <- function(gep, url, width=1440, height=5000) {

  httr::GET(
    url = sprintf("http://%s:%s/render_har", gep$host, gep$port),
    query = list(
      url = url,
      width = width,
      height = height
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- HARtools::readHAR(out)

  out

}

#' Render a page in a javascript context and take a screenshot
#'
#' @md
#' @param gep a gepetto connection object
#' @param url the URL to fetch and render
#' @param width,height viewport width/height
#' @return `magick` image
#' @export
#' @examples \dontrun{
#' gepetto(port=3000) %>%
#'   gep_render_magick("https://r-project.org/")
#' }
gep_render_magick <- function(gep, url, width=1440, height=5000) {
 httr::GET(
   url = sprintf("http://%s:%s/render_png", gep$host, gep$por),
   query = list(
     url = url,
     width = width,
     height = height
   )
 ) -> res
 httr::stop_for_status(res)
 out <- httr::content(res)
 out <- magick::image_read(out)
 out
}

# #' Take a screenshot of the current browser page
# #'
# #' @md
# #' @param gep a gepetto connection object
# #' @return `magick` image
# #' @export
# #' @examples \dontrun{
# #' gepetto(port=3000) %>%
# #'   gep_screenshot()
# #' }
# gep_screenshot <- function(gep) {
#
#   httr::GET(
#     url = sprintf("http://%s:%s/screenshot", gep$host, gep$por),
#   ) -> res
#
#   httr::stop_for_status(res)
#
#   out <- httr::content(res)
#   out <- magick::image_read(out)
#   out
#
# }

#' Render a page in a javascript context and rendero to PDF
#'
#' @md
#' @param gep a gepetto connection object
#' @param url the URL to fetch and render
#' @param path directory & filename to save the PDF to. If `NULL` will be saved
#'        to a tempfile and it location will be returned.
#' @param overwrite if `TRUE` any existing `path` (file) will be overwritten
#' @param width,height viewport width/height
#' @return object
#' @export
#' @examples \dontrun{
#' gepetto(port=3000) %>%
#'   gep_render_pdf("https://r-project.org/")
#' }
gep_render_pdf <- function(gep, url, path=NULL, overwrite=TRUE, width=1440, height=5000) {

  if (is.null(path)) {
    path <- tempfile(fileext = ".pdf")
  } else {
    path <- path.expand(path)
  }

  httr::GET(
    url = sprintf("http://%s:%s/render_pdf", gep$host, gep$por),
    query = list(
      url = url,
      width = width,
      height = height
    ),
    httr::write_disk(path = path)
  ) -> res

  httr::stop_for_status(res)

  path

}

#' Get "debug-level" information of a running gepetto server
#'
#' @md
#' @param gep a gepetto connection object
#' @return debug info
#' @export
#' @examples \dontrun{
#' gepetto() %>%
#'   gep_debug() %>%
#'   str()
#' }
gep_debug <- function(gep) {

  httr::GET(
    url = sprintf("http://%s:%s/_debug", gep$host, gep$port)
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out

}

#' Get test whether the gepetto server is active
#'
#' @md
#' @param gep a gepetto connection object
#' @return logical (`TRUE` if alive)
#' @export
#' @examples \dontrun{
#' gepetto() %>%
#'   gep_active()
#' }
gep_active <- function(gep) {

  s_GET(
    url = sprintf("http://%s:%s/_ping", gep$host, gep$port)
  ) -> res

  res <- stop_for_problem(res)

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out$status == "ok"

}

#' Gracefully stop a gepetto instance
#'
#' @md
#' @param gep a gepetto connection object
#' @export
#' @examples \dontrun{
#' gepetto() %>%
#'   gep_stop()
#' }
gep_stop <- function(gep) {

  s_GET(
    url = sprintf("http://%s:%s/_stop", gep$host, gep$port)
  ) -> res

  res <- stop_for_problem(res)

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out$status == "ok"

}

#' #' Execute Puppeteer commands
#' #'
#' #' This is a **low-level** call that makes **you** responsible for the return
#' #' type. Eventually there will likely be more boilerplate code for handling return
#' #' values.
#' #'
#' #' @md
#' #' @param gep a gepetto connection object
#' #' @param js Puppeteer js to execute in-browser
#' #' @references [Puppeteer API](https://github.com/GoogleChrome/puppeteer/blob/v1.7.0/docs/api.md)
#' #' @export
#' #' @examples \dontrun{
#' #' gepetto() %>%
#' #'   gep_exec()
#' #' }
#' gep_exec <- function(gep, js) {
#'
#'   httr::POST(
#'     url = sprintf("http://%s:%s/exec", gep$host, gep$port),
#'     encode = "form",
#'     body = js
#'   ) -> res
#'
#'   httr::stop_for_status(res)
#'
#'   out <- httr::content(res, as="text")
#'   #   out <- jsonlite::fromJSON(out)
#'   #
#'   out
#'
#' }