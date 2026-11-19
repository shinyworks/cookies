# Extract an individual cookie from a shiny request

The shiny request object includes any cookies that are available to the
app. This function extracts the value of a named cookie from that
request.

## Usage

``` r
extract_cookie(request, cookie_name, missing = NULL)
```

## Arguments

- request:

  A shiny request object.

- cookie_name:

  The name of the cookie. Can contain any US-ASCII characters except
  for: the control character, space, a tab, or separator characters like
  ( ) \< \> @ , ; : \\ " / \[ \] ? = { }.

- missing:

  The value to return if the requested cookie is not stored in the
  request. Defaults to `NULL`.

## Value

The contents of that cookie.

## Examples

``` r
req <- list(HTTP_COOKIE = "cookie1=expected_value; cookie2=1; cookie3=2")
extract_cookie(req, "cookie1")
#> [1] "expected_value"
extract_cookie(req, "cookie2")
#> [1] "1"
extract_cookie(list(), "cookie1")
#> NULL
extract_cookie(NULL, "cookie1")
#> NULL
```
