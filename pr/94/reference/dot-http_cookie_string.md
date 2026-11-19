# Condense cookie attributes to a set-cookie string

Condense cookie attributes to a set-cookie string

## Usage

``` r
.http_cookie_string(
  cookie_name,
  cookie_value,
  expiration,
  secure_only,
  domain,
  path,
  same_site,
  http_only
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

## Value

A string in the form "Set-Cookie: cookie-name=cookie-value;
Expires=date", etc.
