# Attach the js-cookie javascript library for shiny

Add the js-cookie Javascript library as an HTML dependency, and make
cookies available in the shiny input object.

## Usage

``` r
cookie_dependency()
```

## Value

An
[`htmltools::htmlDependency()`](https://rstudio.github.io/htmltools/reference/htmlDependency.html),
which shiny uses to add the js-cookie Javascript library exactly once.

## Details

Call this function within your shiny ui to attach the necessary
JavaScript code.

## Examples

``` r
cookie_dependency()
#> [[1]]
#> List of 10
#>  $ name      : chr "js-cookie"
#>  $ version   : chr "3.0.1"
#>  $ src       :List of 2
#>   ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
#>   ..$ file: chr "js"
#>  $ meta      : NULL
#>  $ script    : chr "js.cookie.min.js"
#>  $ stylesheet: NULL
#>  $ head      : NULL
#>  $ attachment: NULL
#>  $ package   : chr "cookies"
#>  $ all_files : logi TRUE
#>  - attr(*, "class")= chr "html_dependency"
#> 
#> [[2]]
#> List of 10
#>  $ name      : chr "cookie_input"
#>  $ version   : chr "1.0.0"
#>  $ src       :List of 1
#>   ..$ file: chr "js"
#>  $ meta      : NULL
#>  $ script    : chr "cookie_input.js"
#>  $ stylesheet: NULL
#>  $ head      : NULL
#>  $ attachment: NULL
#>  $ package   : chr "cookies"
#>  $ all_files : logi TRUE
#>  - attr(*, "class")= chr "html_dependency"
#> 
```
