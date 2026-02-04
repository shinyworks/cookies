# Shiny tag to add cookies on page load

Generate a
[`shiny::tagList()`](https://rdrr.io/pkg/shiny/man/reexports.html) which
uses JavaScript to set a cookie in the user's browser when the shiny app
loads.

## Usage

``` r
set_cookie_on_load(
  cookie_name,
  cookie_value,
  expiration = 90,
  secure_only = NULL,
  domain = NULL,
  path = NULL,
  same_site = NULL
)
```

## Arguments

- cookie_name:

  The name of the cookie. Can contain any US-ASCII characters except
  for: the control character, space, a tab, or separator characters like
  ( ) \< \> @ , ; : \\ " / \[ \] ? = { }.

- cookie_value:

  The contents of the cookie as a single character value.

- expiration:

  Days after which the cookie should expire. To remove an HttpOnly
  cookie, send a negative value for this attribute.

- secure_only:

  Logical indicating whether the cookie should only be accessible via
  secure (`https:`) requests (except on localhost).

- domain:

  The host to which the cookie will be sent (including subdomains). If
  this is `NULL` (default) the cookie will only be sent to the host of
  the page where this cookie was set (not including subdomains).

- path:

  The path that must exist in the requested URL for the browser to send
  this cookie. Includes subdirectories.

- same_site:

  One of "strict", "lax" (default), or "none", indicating when the
  cookie should be sent. When `same_site = "none"`, `secure_only` must
  be `TRUE`.

## Value

A [`shiny::tagList()`](https://rdrr.io/pkg/shiny/man/reexports.html)
that provides the HTML and javascript to set the cookie.

## Examples

``` r
set_cookie_on_load("my_cookie", "contents of my cookie")
#> <script>Cookies.set("my_cookie", "contents of my cookie", {"expires":90});</script>
set_cookie_on_load("my_cookie", "contents of my cookie", expiration = 10)
#> <script>Cookies.set("my_cookie", "contents of my cookie", {"expires":10});</script>
```
