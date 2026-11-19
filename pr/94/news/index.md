# Changelog

## cookies (development version)

## cookies 0.2.3

CRAN release: 2023-10-02

- Better handling of race-time conditions between R and JavaScript
  ([\#63](https://github.com/shinyworks/cookies/issues/63)).
- Cleaner tests.

## cookies 0.2.2

CRAN release: 2023-03-15

- Updated cookie handling to allow HttpOnly cookies mixed with
  JavaScript cookies, and improved error messages
  ([\#54](https://github.com/shinyworks/cookies/issues/54)).
- Updated cookie handling to find cookies even if the call comes from
  inside a module
  ([\#56](https://github.com/shinyworks/cookies/issues/56)).

## cookies 0.2.1

CRAN release: 2023-01-10

- The underlying ‘js-cookie’ JavaScript library now loads from source if
  it is available
  ([\#42](https://github.com/shinyworks/cookies/issues/42)).
- Clarified the help for
  [`cookie_dependency()`](https://cookies.shinyworks.org/reference/cookie_dependency.md)
  and
  [`add_cookie_handlers()`](https://cookies.shinyworks.org/reference/add_cookie_handlers.md),
  to hopefully make it clearer how they can be applied in any situation
  ([\#37](https://github.com/shinyworks/cookies/issues/37)).
- Updated
  [`get_cookie()`](https://cookies.shinyworks.org/reference/get_cookie.md)
  to properly update if a cookie is deleted during the session but was
  available at the start of the session.

## cookies 0.2.0

CRAN release: 2022-11-30

- Added
  [`get_cookie()`](https://cookies.shinyworks.org/reference/get_cookie.md)
  to more easily get cookies within the server
  ([\#32](https://github.com/shinyworks/cookies/issues/32)).
- Added `missing` as a parameter to
  [`get_cookie()`](https://cookies.shinyworks.org/reference/get_cookie.md)
  and
  [`extract_cookie()`](https://cookies.shinyworks.org/reference/extract_cookie.md)
  for when the cookie doesn’t exist
  ([@jnolis](https://github.com/jnolis),
  [\#38](https://github.com/shinyworks/cookies/issues/38)).
- Changed the default behavior for missing cookies from `NA` to `NULL`
  to be more in line with R convention
  ([@jnolis](https://github.com/jnolis)).

## cookies 0.1.1

CRAN release: 2022-11-01

- Updated a test. No user-facing changes.

## cookies 0.1.0

CRAN release: 2022-11-01

- Initial CRAN release.
- Added
  [`set_cookie_response()`](https://cookies.shinyworks.org/reference/set_cookie_response.md)
  to set and remove cookies using more-secure HTTP responses
  ([\#10](https://github.com/shinyworks/cookies/issues/10),
  [\#17](https://github.com/shinyworks/cookies/issues/17),
  [\#21](https://github.com/shinyworks/cookies/issues/21),
  [\#22](https://github.com/shinyworks/cookies/issues/22)).
- Added
  [`set_cookie()`](https://cookies.shinyworks.org/reference/set_cookie.md)
  and
  [`remove_cookie()`](https://cookies.shinyworks.org/reference/remove_cookie.md)
  to handle cookies from the server (using JavaScript)
  ([\#5](https://github.com/shinyworks/cookies/issues/5),
  [\#6](https://github.com/shinyworks/cookies/issues/6)).
- Added
  [`set_cookie_on_load()`](https://cookies.shinyworks.org/reference/set_cookie_on_load.md)
  to set a cookie when the shiny app loads
  ([\#4](https://github.com/shinyworks/cookies/issues/4)).
- Added
  [`add_cookie_handlers()`](https://cookies.shinyworks.org/reference/add_cookie_handlers.md)
  to wrap a shiny ui and add cookie functionality
  ([\#3](https://github.com/shinyworks/cookies/issues/3)).
- Added
  [`extract_cookie()`](https://cookies.shinyworks.org/reference/extract_cookie.md)
  and
  [`extract_cookies()`](https://cookies.shinyworks.org/reference/extract_cookies.md)
  to extract cookies from request object.
