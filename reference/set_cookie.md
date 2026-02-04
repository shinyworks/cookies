# Create or update a cookie

Instruct the user's browser to create a cookie via JavaScript.

## Usage

``` r
set_cookie(
  cookie_name,
  cookie_value,
  expiration = 90,
  secure_only = NULL,
  domain = NULL,
  path = NULL,
  same_site = NULL,
  session = shiny::getDefaultReactiveDomain()
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

- session:

  Shiny session in which the cookies can be found (the default should
  probably always be used).

## Value

A call to `session$sendCustomMessage()` which sets the targeted cookie.

## Examples

``` r
server <- function(input, output, server) {
  shiny::observeEvent(
    input$button_that_sets_cookie,
    set_cookie(
      "my_cookie",
      "the value of this cookie"
    )
  )
}
```
