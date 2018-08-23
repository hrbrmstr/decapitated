
# decapitated

Headless ‘Chrome’ Orchestration

## Description

The ‘Chrome’ browser <https://www.google.com/chrome/> has a headless
mode which can be instrumented programmatically. Tools are provided to
perform headless ‘Chrome’ instrumentation on the command-line, including
retrieving the javascript-executed web page, PDF output or screen shot
of a URL.

## IMPORTANT

You'll need to set an envrionment variable `HEADLESS_CHROME` to use this package.

If this value is not set, a location heuristic is used on package start which looks
for the following depending on the operating system:

- Windows(32bit): `C:/Program Files/Google/Chrome/Application/chrome.exe`
- Windows(64bit): `C:/Program Files (x86)/Google/Chrome/Application/chrome.exe`
- macOS: `/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome`
- Linux: `/usr/bin/google-chrome`

If a verification test fails, you will be notified. 

**It is HIGHLY recommended** that you use `decapitated::download_chromium()` to use
a standalone version of Chrome with this packge for your platform. 

It's best to use `~/.Renviron` to store this value.

## Working around headless Chrome & OS security restrictions:

Security restrictions on various operating systems and OS configurations
can cause headless Chrome execution to fail. As a result, headless
Chrome operations should use a special directory for `decapitated`
package operations. You can pass this in as `work_dir`. If `work_dir` is
`NULL` a `.rdecapdata` directory will be created in your home directory
and used for the data, crash dumps and utility directories for Chrome
operations.

`tempdir()` does not always meet these requirements (after testing on
various macOS 10.13 systems) as Chrome does some interesting attribute
setting for some of its file operations.

If you pass in a `work_dir`, it must be one that does not violate OS
security restrictions or headless Chrome will not function.

## Helping it “always work”

The three core functions have a `prime` parameter. In testing (again,
especially on macOS), I noticed that the first one or two requests to a
URL often resulted in an empty `<body>` response. I don’t use Chrome as
my primary browser anymore so I’m not sure if that has something to do
with it, but requests after the first one or two do return content. The
`prime` parameter lets you specify `TRUE`, `FALSE` or a numeric value
that will issue the URL retrieval multiple times before returning a
result (or generating a PDF or PNG). Until there is more granular
control over the command-line execution of headless Chrome.

## What’s in the tin?

The following functions are implemented:

### CLI-based ops

- `downlaod_chromium`:  Download a standalone version of Chromium (recommended)
- `chrome_dump_pdf`:	"Print" to PDF
- `chrome_read_html`:	Read a URL via headless Chrome and return the raw or rendered '<body>' 'innerHTML' DOM elements
- `chrome_shot`:	Capture a screenshot
- `chrome_version`:	Get Chrome version
- `get_chrome_env`:	get an envrionment variable 'HEADLESS_CHROME'
- `set_chrome_env`:	set an envrionment variable 'HEADLESS_CHROME'

### `gepetto`-based ops

- `gepetto`:	Create a connection to a Gepetto API server
- `gep_active`:	Get test whether the gepetto server is active
- `gep_debug`:	Get "debug-level" information of a running gepetto server
- `gep_render_har`:	Render a page in a javascript context and serialize to HAR
- `gep_render_html`:	Render a page in a javascript context and serialize to HTML
- `gep_render_magick`:	Render a page in a javascript context and take a screenshot
- `gep_render_pdf`:	Render a page in a javascript context and rendero to PDF

More information on `gepetto` is forthcoming but you can take a sneak peek [here](https://gitlab.com/hrbrmstr/gepetto).

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

    ## [1] '0.3.0'

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
