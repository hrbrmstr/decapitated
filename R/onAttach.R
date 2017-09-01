.onAttach <- function(libname, pkgname) {
  if (interactive()) {
    if ( unname(Sys.info()["sysname"] == "Windows") ){
      if ( unname(Sys.info()["machine"] == "x86-64") ) {
        Sys.setenv(HEADLESS_CHROME="C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
      } else {
        Sys.setenv(HEADLESS_CHROME="C:/Program Files/Google/Chrome/Application/chrome.exe")
      }
    }
    if ( unname(Sys.info()["sysname"] == "Darwin") ){
      Sys.setenv(HEADLESS_CHROME="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome")
    }
    # check other os
    chrome_bin <- Sys.getenv("HEADLESS_CHROME")
  }
}