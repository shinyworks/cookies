# Read a cookie

Read a cookie from the input object.

## Usage

``` r
get_cookie(
  cookie_name,
  missing = NULL,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- cookie_name:

  The name of the cookie. Can contain any US-ASCII characters except
  for: the control character, space, a tab, or separator characters like
  ( ) \< \> @ , ; : \\ " / \[ \] ? = { }.

- missing:

  The value to return if the requested cookie does not exist. Defaults
  to NULL.

- session:

  Shiny session in which the cookies can be found (the default should
  probably always be used).

## Value

A character with the value of the cookie.

## Examples

``` r
server <- function(input, output, session) {
  get_cookie("my_cookie")
}
```
