#' Download a standalone version of Chromium (recommended)
#'
#' @md
#' @param path where to store the Chromium app.
#' @param chromium_revision version to download (keep default unless you require
#'        a specific version)
#' @export
download_chromium <- function(path = NULL, chromium_revision = 579032) {

  path <- path.expand(path)
  stopifnot(dir.exists(path))

  dl_src_path <-'https://storage.googleapis.com'

  list(
    linux= '%s/chromium-browser-snapshots/Linux_x64/%d/chrome-linux.zip',
    mac = '%s/chromium-browser-snapshots/Mac/%d/chrome-mac.zip',
    win32 = '%s/chromium-browser-snapshots/Win/%d/chrome-win32.zip',
    win64 = '%s/chromium-browser-snapshots/Win_x64/%d/chrome-win32.zip'
  ) -> dl_urls


  dl <- if (unname(Sys.info()["sysname"] == "Windows")) {
    if (unname(Sys.info()["machine"] == "x86-64")) "win64" else "win32"
  } else if (unname(Sys.info()["sysname"] == "Darwin")) {
    "mac"
  } else if (unname(Sys.info()["sysname"] == "Linux")) {
    "linux"
  } else {
    stop("Unrecognized platform", call.=FALSE)
  }

  dl_url <- sprintf(dl_urls[[dl]], dl_src_path, chromium_revision)
  dl_fil <- file.path(path, basename(dl_url))

  message("Downloading ", dl_url)

  download.file(dl_url, dl_fil, mode="wb")
  on.exit(unlink(dl_fil), add=TRUE)

  unzip(dl_fil, unzip = getOption("unzip"), exdir = path)
  for (fil in list.files(path, recursive = TRUE)) Sys.chmod(fil, "0755")

  chrome_ex_path <- if (unname(Sys.info()["sysname"] == "Windows")) {
    file.path(path, "chrome-win32", "chrome.exe")
  } else if (unname(Sys.info()["sysname"] == "Darwin")) {
    file.path(path, "chrome-mac", "Chromium.app", "Contents", "MacOS", "Chromium")
  } else if (unname(Sys.info()["sysname"] == "Linux")) {
    file.path(path, "chrome-linux", "chrome")
  }

  message(
    sprintf(
      "Please set the HEADLESS_CHROME environment variable to:\n  '%s'\n\n", chrome_ex_path
    ), "This value has also been returned invisibly."
  )

  invisible(chrome_ex_path)

}



