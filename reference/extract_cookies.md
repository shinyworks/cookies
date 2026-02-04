# Extract all cookies from a shiny request

The shiny request object includes any cookies that are available to the
app. This function extracts those cookies as a named list.

## Usage

``` r
extract_cookies(request)
```

## Arguments

- request:

  A shiny request object.

## Value

All cookies in the request, as a list.

## Examples

``` r
req <- list(HTTP_COOKIE = "cookie1=expected_value; cookie2=1; cookie3=2")
extract_cookies(req)
#> $cookie1
#> [1] "expected_value"
#> 
#> $cookie2
#> [1] "1"
#> 
#> $cookie3
#> [1] "2"
#> 
extract_cookies(list())
#> NULL
extract_cookies(NULL)
#> NULL
```
