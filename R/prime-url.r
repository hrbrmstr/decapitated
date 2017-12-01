.prime_url <- function(url, prime_ct = 1, work_dir=NULL,
                       chrome_bin=Sys.getenv("HEADLESS_CHROME")) {

  work_dir <- if (is.null(work_dir)) .get_app_dir() else work_dir

  args <- c("--headless")
  args <- c(args, "--disable-gpu")
  args <- c(args, "--no-sandbox")
  args <- c(args, "--allow-no-sandbox-job")
  args <- c(args, sprintf("--user-data-dir=%s", work_dir))
  args <- c(args, sprintf("--crash-dumps-dir=%s", work_dir))
  args <- c(args, sprintf("--utility-allowed-dir=%s", work_dir))
  args <- c(args, "--dump-dom", url)

  for (i in 1:prime_ct) {
    processx::run(
      command = chrome_bin,
      args = args,
      error_on_status = FALSE,
      echo_cmd = FALSE,
      echo = FALSE
    ) -> res
  }

}
