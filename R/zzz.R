.onAttach <- function(libname, pkgname) {

  HEADLESS_CHROME <- Sys.getenv("HEADLESS_CHROME")

  if (interactive()) {

    if (HEADLESS_CHROME == "") {

      if (unname(Sys.info()["sysname"] == "Windows")) {

        if (unname(Sys.info()["machine"] == "x86-64")) {
          HEADLESS_CHROME <- "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
        } else {
          HEADLESS_CHROME <- "C:/Program Files/Google/Chrome/Application/chrome.exe"
        }

      }

      if (unname(Sys.info()["sysname"] == "Darwin")) {
        HEADLESS_CHROME <- "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
      }

      if (unname(Sys.info()["sysname"] == "Linux")) {
        HEADLESS_CHROME <- "/usr/bin/google-chrome"
      }

    }

    if (file.exists(HEADLESS_CHROME)) {
      Sys.setenv("HEADLESS_CHROME"=HEADLESS_CHROME)
      packageStartupMessage(
        sprintf("Using Chrome binary from [%s].\n", Sys.getenv("HEADLESS_CHROME"))
      )
    } else {
      packageStartupMessage(
        sprintf("Chrome binary not found at [%s].\n", Sys.getenv("HEADLESS_CHROME")),
        "Please use decapitated::download_chromium() and set the HEADLESS_CHROME ",
        "environment variable to the value returned from the function."
      )
    }


  }

}