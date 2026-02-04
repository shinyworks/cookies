# Add cookies to an existing shiny ui

Wrap a shiny ui in this function in order to add cookie-handling
functionality. The ui can be defined in any format compatible with
shiny, using functions such as
[`shiny::fluidPage()`](https://rdrr.io/pkg/shiny/man/fluidPage.html),
[`shiny::bootstrapPage()`](https://rdrr.io/pkg/shiny/man/bootstrapPage.html),
[`shiny::htmlTemplate()`](https://rdrr.io/pkg/shiny/man/reexports.html),
or a raw HTML string.

## Usage

``` r
add_cookie_handlers(ui)
```

## Arguments

- ui:

  A 0- or 1-argument function defining the ui of a shiny app, or a
  [`shiny::tagList()`](https://rdrr.io/pkg/shiny/man/reexports.html).

## Value

An object with the same signature as the input `ui`, but with the
dependencies needed to handle cookies. If `ui` is a
[`shiny::tagList()`](https://rdrr.io/pkg/shiny/man/reexports.html), a
[`shiny::tagList()`](https://rdrr.io/pkg/shiny/man/reexports.html) will
be returned; if `ui` is a function, a function will be returned.

## Examples

``` r
str(add_cookie_handlers("example"))
#> List of 2
#>  $ :List of 2
#>   ..$ :List of 10
#>   .. ..$ name      : chr "js-cookie"
#>   .. ..$ version   : chr "3.0.1"
#>   .. ..$ src       :List of 2
#>   .. .. ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
#>   .. .. ..$ file: chr "js"
#>   .. ..$ meta      : NULL
#>   .. ..$ script    : chr "js.cookie.min.js"
#>   .. ..$ stylesheet: NULL
#>   .. ..$ head      : NULL
#>   .. ..$ attachment: NULL
#>   .. ..$ package   : chr "cookies"
#>   .. ..$ all_files : logi TRUE
#>   .. ..- attr(*, "class")= chr "html_dependency"
#>   ..$ :List of 10
#>   .. ..$ name      : chr "cookie_input"
#>   .. ..$ version   : chr "1.0.0"
#>   .. ..$ src       :List of 1
#>   .. .. ..$ file: chr "js"
#>   .. ..$ meta      : NULL
#>   .. ..$ script    : chr "cookie_input.js"
#>   .. ..$ stylesheet: NULL
#>   .. ..$ head      : NULL
#>   .. ..$ attachment: NULL
#>   .. ..$ package   : chr "cookies"
#>   .. ..$ all_files : logi TRUE
#>   .. ..- attr(*, "class")= chr "html_dependency"
#>  $ : chr "example"
#>  - attr(*, "class")= chr [1:2] "shiny.tag.list" "list"
```
