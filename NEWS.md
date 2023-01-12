# cookies (development version)

* Updated cookie handling to allow HttpOnly cookies mixed with JavaScript cookies, and improved error messages (#54).

# cookies 0.2.1

* The underlying 'js-cookie' JavaScript library now loads from source if it is available (#42).
* Clarified the help for `cookie_dependency()` and `add_cookie_handlers()`, to hopefully make it clearer how they can be applied in any situation (#37).
* Updated `get_cookie()` to properly update if a cookie is deleted during the session but was available at the start of the session.

# cookies 0.2.0

* Added `get_cookie()` to more easily get cookies within the server (#32).
* Added `missing` as a parameter to `get_cookie()` and `extract_cookie()` for when the cookie doesn't exist (@jnolis, #38).
* Changed the default behavior for missing cookies from `NA` to `NULL` to be more in line with R convention (@jnolis).

# cookies 0.1.1

* Updated a test. No user-facing changes.

# cookies 0.1.0

* Initial CRAN release.
* Added `set_cookie_response()` to set and remove cookies using more-secure HTTP responses (#10, #17, #21, #22).
* Added `set_cookie()` and `remove_cookie()` to handle cookies from the server (using JavaScript) (#5, #6).
* Added `set_cookie_on_load()` to set a cookie when the shiny app loads (#4).
* Added `add_cookie_handlers()`  to wrap a shiny ui and add cookie functionality (#3).
* Added `extract_cookie()` and `extract_cookies()` to extract cookies from request object.
