#' Headless 'Chrome' Orchestration
#'
#' The 'Chrome' browser <https://www.google.com/chrome/> has a headless mode
#' which can be instrumented programmatically. Tools are provided to perform headless
#' Chrome' instrumentation on the command-line, including retrieving the javascript-executed
#' web page, PDF output or screen shot of a URL.
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
#' @section Important:
#'
#' You'll need to set an envrionment variable `HEADLESS_CHROME` to use this package.
#'
#' If this value is not set, a location heuristic is used on package start which looks
#' for the following depending on the operating system:
#'
#' - Windows(32bit): `C:/Program Files/Google/Chrome/Application/chrome.exe`
#' - Windows(64bit): `C:/Program Files (x86)/Google/Chrome/Application/chrome.exe`
#' - macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome`
#' - Linux: `/usr/bin/google-chrome`
#'
#' If a verification test fails, you will be notified.
#'
#' **It is HIGHLY recommended** that you use `decapitated::download_chromium()` to use
#' a standalone version of Chrome with this packge for your platform.
#'
#' It's best to use `~/.Renviron` to store this value.
#'
#'
#' @md
#' @name decapitated
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import xml2 magick processx tools utils httr
#' @importFrom jsonlite fromJSON
#' @importFrom HARtools readHAR
NULL