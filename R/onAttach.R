.onAttach <- function(libname, pkgname) {

  if (interactive()) {

    if (Sys.getenv("HEADLESS_CHROME") == "") {

      if (unname(Sys.info()["sysname"] == "Windows")) {

        if (unname(Sys.info()["machine"] == "x86-64")) {
          Sys.setenv(HEADLESS_CHROME="C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
        } else {
          Sys.setenv(HEADLESS_CHROME="C:/Program Files/Google/Chrome/Application/chrome.exe")
        }

      }

      if (unname(Sys.info()["sysname"] == "Darwin")) {
        Sys.setenv(HEADLESS_CHROME="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome")
      }

      if (unname(Sys.info()["sysname"] == "Lniux")) {
        Sys.setenv(HEADLESS_CHROME="/usr/bin/google-chrome")
      }

      message(sprintf("Set Chrome binary to [%s].\nPass in manually to functions or use decapitated::set_chrome_env()",
                      Sys.getenv("HEADLESS_CHROME")))

    }

  }

}