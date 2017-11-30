#' Headless 'Chrome' Orchestration
#'
#' The 'Chrome' browser <https://www.google.com/chrome/> has a headless mode
#' which can be instrumented programmatically. Tools are provided to perform headless
#' 'Chrome' instrumentation on the command-line and will eventually provide support
#' for the 'DevTools' instrumentation 'API' or the forthcoming 'phantomjs'-like higher-level
#' 'API' being promised by the development team.
#'
#' @section Important:
#'
#' This pkg will eventually do much under the covers to find the location of the Chrome binary
#' on all operating systems. For now, you'll need to set an envrionment variable `HEADLESS_CHROME` to one of these two values:
#'
#' - Windows(32bit): `C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe`
#' - Windows(64bit): `C:\\Program Files (x86)/Google\\Chrome\\Application\\chrome.exe`
#' - macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome`
#' - Linux: `/usr/bin/google-chrome`
#'
#' A guess is made (but not verified yet) if `HEADLESS_CHROME` is non-existent.
#'
#' Use `~/.Renviron` to store this value for the time being.
#'
#' @md
#' @name decapitated
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import xml2 magick
NULL