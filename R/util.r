
stop_for_problem <- function(res) {
  if (is.null(res$result)) stop(res$error$message, call.=FALSE) else res$result
}

.get_app_dir <- function() {
  ddir <- file.path(Sys.getenv("HOME"), ".rdecapdata")
  if (!dir.exists(ddir)) {
    message(sprintf("Creating application data directory [%s]...", ddir))
    dir.create(ddir, recursive=TRUE)
  }
  return(ddir)
}