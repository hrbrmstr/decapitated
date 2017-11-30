
# decapitated

Headless 'Chrome' Orchestration

## Description

The 'Chrome' browser <https://www.google.com/chrome/> has a headless mode which can be instrumented programmatically. Tools are provided to perform headless 'Chrome' instrumentation on the command-line and will eventually provide support for the 'DevTools' instrumentation 'API' or the forthcoming 'phantomjs'-like higher-level 'API' being promised by the development team.

## IMPORTANT

macOS High Sierra and Headless Chrome dinna work so good together.

This pkg will eventually do much under the covers to find the location of the Chrome binary on all operating systems. For now, you'll need to set an envrionment variable `HEADLESS_CHROME` to one of these two values:

- Windows(32bit): `C:/Program Files/Google/Chrome/Application/chrome.exe`
- Windows(64bit): `C:/Program Files (x86)/Google/Chrome/Application/chrome.exe`
- macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome`
- Linux: `/usr/bin/google-chrome`

A guess is made (but not verified yet) if `HEADLESS_CHROME` is non-existent.

Use `~/.Renviron` to store this value for the time being.

The following functions are implemented:

-   `chrome_dump_pdf`: "Print" to PDF
-   `chrome_read_html`: Read a URL via headless Chrome and return the renderd '
    <body>
    ' 'innerHTML' DOM elements
-   `chrome_shot`: Capture a screenshot
-   `chrome_version`: Get Chrome version
-   `get_chrome_env`:	get an envrionment variable 'HEADLESS_CHROME'
-   `set_chrome_env`:	set an envrionment variable 'HEADLESS_CHROME'

## Installation

``` r
devtools::install_github("hrbrmstr/decapitated")
```

## Usage

``` r
library(decapitated)

# current verison
packageVersion("decapitated")
```

    ## [1] '0.2.0'

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

