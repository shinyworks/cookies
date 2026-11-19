# Remove a cookie

Instruct the user's browser to remove a cookie via JavaScript.

## Usage

``` r
remove_cookie(cookie_name, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- cookie_name:

  The name of the cookie. Can contain any US-ASCII characters except
  for: the control character, space, a tab, or separator characters like
  ( ) \< \> @ , ; : \\ " / \[ \] ? = { }.

- session:

  Shiny session in which the cookies can be found (the default should
  probably always be used).

## Value

A call to `session$sendCustomMessage()` which removes the targeted
cookie.

## Examples

``` r
server <- function(input, output, server) {
  shiny::observeEvent(
    input$button_that_removes_cookie,
    remove_cookie("my_cookie")
  )
}
```
