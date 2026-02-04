# Set cookie via HTTP header

Send a
[`shiny::httpResponse()`](https://rdrr.io/pkg/shiny/man/httpResponse.html)
that sets a cookie in the user's browser. Note that this does *not*
return a full shiny ui.

## Usage

``` r
set_cookie_response(
  cookie_name,
  cookie_value,
  expiration = 90,
  secure_only = NULL,
  domain = NULL,
  path = NULL,
  same_site = NULL,
  http_only = FALSE,
  redirect = NULL,
  ...
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

- http_only:

  Logical indicating whether the cookie should only be sent as part of
  an HTTP request. When this is `FALSE` (default), the cookie is
  accessible to JavaScript via the `Document.cookie` property.

- redirect:

  A relative or absolute URL where the user should be sent next. A
  typical case would be the same URL minus the query parameter that
  triggered the Set-cookie response.

- ...:

  Additional parameters passed on to
  [`shiny::httpResponse()`](https://rdrr.io/pkg/shiny/man/httpResponse.html).

## Value

A
[`shiny::httpResponse()`](https://rdrr.io/pkg/shiny/man/httpResponse.html)
that sets the cookie.

## Examples

``` r
set_cookie_response("my_cookie", "contents of my cookie")
#> $status
#> [1] 200
#> 
#> $content_type
#> [1] "text/html; charset=UTF-8"
#> 
#> $content
#> [1] ""
#> 
#> $headers
#> $headers$`Set-cookie`
#> my_cookie=contents%20of%20my%20cookie; Expires=Tue, 05 May 2026 11:59:51 GMT
#> 
#> $headers$`X-UA-Compatible`
#> [1] "IE=edge,chrome=1"
#> 
#> 
#> attr(,"class")
#> [1] "httpResponse"
set_cookie_response("my_cookie", "contents of my cookie", expiration = 10)
#> $status
#> [1] 200
#> 
#> $content_type
#> [1] "text/html; charset=UTF-8"
#> 
#> $content
#> [1] ""
#> 
#> $headers
#> $headers$`Set-cookie`
#> my_cookie=contents%20of%20my%20cookie; Expires=Sat, 14 Feb 2026 11:59:51 GMT
#> 
#> $headers$`X-UA-Compatible`
#> [1] "IE=edge,chrome=1"
#> 
#> 
#> attr(,"class")
#> [1] "httpResponse"
set_cookie_response(
  "my_cookie", "contents of my cookie",
  content = "Your cookie is set."
)
#> $status
#> [1] 200
#> 
#> $content_type
#> [1] "text/html; charset=UTF-8"
#> 
#> $content
#> [1] "Your cookie is set."
#> 
#> $headers
#> $headers$`Set-cookie`
#> my_cookie=contents%20of%20my%20cookie; Expires=Tue, 05 May 2026 11:59:51 GMT
#> 
#> $headers$`X-UA-Compatible`
#> [1] "IE=edge,chrome=1"
#> 
#> 
#> attr(,"class")
#> [1] "httpResponse"
set_cookie_response(
  "my_cookie", "contents of my cookie",
  redirect = "/"
)
#> $status
#> [1] 302
#> 
#> $content_type
#> [1] "text/html; charset=UTF-8"
#> 
#> $content
#> [1] ""
#> 
#> $headers
#> $headers$`Set-cookie`
#> my_cookie=contents%20of%20my%20cookie; Expires=Tue, 05 May 2026 11:59:51 GMT
#> 
#> $headers$Location
#> [1] "/"
#> 
#> $headers$`X-UA-Compatible`
#> [1] "IE=edge,chrome=1"
#> 
#> 
#> attr(,"class")
#> [1] "httpResponse"
```
