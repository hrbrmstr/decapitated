
# decapitated

Headless ‘Chrome’ Orchestration

## Description

The ‘Chrome’ browser <https://www.google.com/chrome/> has a headless
mode which can be instrumented programmatically. Tools are provided to
perform headless ‘Chrome’ instrumentation on the command-line, including
retrieving the javascript-executed web page, PDF output or screen shot
of a URL.

### IMPORTANT

You’ll need to set an envrionment variable `HEADLESS_CHROME` to one of
these two values:

  - Windows(32bit): `C:/Program
    Files/Google/Chrome/Application/chrome.exe`
  - Windows(64bit): `C:/Program Files
    (x86)/Google/Chrome/Application/chrome.exe`
  - macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\
    Chrome`
  - Linux: `/usr/bin/google-chrome`

A guess is made (but not verified yet) if `HEADLESS_CHROME` is
non-existent.

It’s best to use `~/.Renviron` to store this value for the time being.

## What’s in the tin?

The following functions are implemented:

  - `chrome_dump_pdf`: “Print” to PDF
  - `chrome_read_html`: Read a URL via headless Chrome and return the
    raw or rendered ’
    <body>
    ‘’innerHTML’ DOM elements
  - `chrome_shot`: Capture a screenshot
  - `chrome_version`: Get Chrome version
  - `get_chrome_env`: get an envrionment variable ‘HEADLESS\_CHROME’
  - `set_chrome_env`: set an envrionment variable ‘HEADLESS\_CHROME’

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

    ## [1] '0.1.0'

``` r
chrome_version()

chrome_read_html("http://httpbin.org/")
```

    ## {xml_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n<meta http-equiv="content-type" valu ...
    ## [2] <body id="manpage">\n<a href="http://github.com/kennethreitz/httpbin"><img style="position: absolute; top: 0; rig ...

``` r
chrome_dump_pdf("http://httpbin.org/")
```

``` r
chrome_shot("http://httpbin.org/")

##   format width height colorspace filesize
## 1    PNG  1600   1200       sRGB   215680
```

![screenshot.png](screenshot.png)
