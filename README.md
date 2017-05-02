
`decapitated` : Headless 'Chrome' Orchestration

The 'Chrome' browser <https://www.google.com/chrome/> has a headless mode which can be instrumented programmatically. Tools are provided to perform headless 'Chrome' instrumentation on the command-line and will eventually provide support for the 'DevTools' instrumentation 'API' or the forthcoming 'phantomjs'-like higher-level 'API' being promised by the development team.

### IMPORTANT

This pkg will eventually do much under the covers to find the location of the Chrome binary on all operating systems. For now, you'll need to set an envrionment variable `HEADLESS_CHROME` to one of these two values:

-   Windows: `C:\Program Files\Google\Chrome\Application\chrome.exe`
-   macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome`

Linux folks will know where their binary is (many of you use non-default locations for things).

Use `~/.Renviron` to store this value for the time being.

The following functions are implemented:

-   `chrome_dump_pdf`: "Print" to PDF
-   `chrome_read_html`: Read a URL via headless Chrome and return the renderd '
    <body>
    ' 'innerHTML' DOM elements
-   `chrome_shot`: Capture a screenshot
-   `chrome_version`: Get Chrome version

### Installation

``` r
devtools::install_github("hrbrmstr/decapitated")
```

### Usage

``` r
library(decapitated)

# current verison
packageVersion("decapitated")
```

    ## [1] '0.1.0'

``` r
chrome_version()

chrome_read_html("http://httpbin.org/")
```

    ## {xml_document}
    ## <html>
    ## [1] <body id="manpage"></body>

``` r
chrome_dump_pdf("http://httpbin.org/")
## [0502/094321.911089:INFO:headless_shell.cc(436)] Written to file output.pdf.
```

``` r
chrome_shot("http://httpbin.org/")

## [0502/094257.370837:INFO:headless_shell.cc(436)] Written to file screenshot.png.
##   format width height colorspace filesize
## 1    PNG  1600   1200       sRGB   238967
```

![](screenshot.png)

### Test Results

``` r
library(decapitated)
library(testthat)

date()
```

    ## [1] "Tue May  2 09:45:23 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
