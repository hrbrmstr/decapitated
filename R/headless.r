#' #' Issue commands to the headless REPL
#' #'
#' #' HIGHLY EXPERIMENTAL
#' #'
#' #' @md
#' #' @param url visit this URL on start
#' #' @export
#' decapitate <- function(cmds, url, pass = rstudioapi::askForPassword()) {
#'
#'   tf <- tempfile(fileext = ".cmds")
#'
#'   on.exit(unlink(tf))
#'
#'   writeLines(c(pass, cmds, "quit"), con = tf)
#'
#'   args <- c("--headless", "--disable-gpu", "--repl")
#'
#'   if (Sys.info()["sysname"] == "Darwin") {
#'     tmp <- system2("sudo", c("-kS", gsub(" ", "\\\\ ", chrome_bin), args, url), stdout=TRUE, stdin=tf)
#'   } else {
#'     tmp <- system2(gsub(" ", "\\\\ ", chrome_bin), c(args, url), stdout=TRUE, stdin=tf)
#'   }
#'
#'   tmp
#'
#' }
#'
#'
#' decapitate(c("location.href", "document.body.outerText"), "https://rud.is/")
