
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cookies

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/r4ds/cookies/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r4ds/cookies?branch=main)
[![R-CMD-check](https://github.com/r4ds/cookies/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r4ds/cookies/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Cookies are name-value pairs that are saved in your browser by a
website. Cookies allow websites to persist information about the user
and their use of the website. The goal of {cookies} it to make it as
easy as possible to use cookies in Shiny apps.

## Installation

I intend to release this package to CRAN as soon as I finish the basic
functionality.

You can install the development version of {cookies} from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("r4ds/cookies")
```

## Examples

Wrap your ui with `add_cookie_handlers()` to add a `cookie` object to
the shiny `input`.

``` r
ui <- shiny::fluidPage(
    title = "Hello Shiny!",
  fluidRow(
    column(width = 4,
      "4"
    ),
    column(width = 3, offset = 2,
      "3 offset 2"
    )
  )
)

ui_with_cookie_handlers <- add_cookie_handlers(ui)
```

To set a cookie when the user loads the app, use `set_cookie_on_load()`.

``` r
part_of_ui <- set_cookie_on_load(
  name = "my_cookie", 
  contents = "contents of my cookie",
  expiration = 10
)
```

Use `set_cookie()` and `remove_cookie()` to manage cookies in your app.

``` r
server <- function(input, output, session) {
  shiny::observeEvent(input$cookie_set, {
    set_cookie(
      name = "my_cookie",
      contents = "contents of my cookie",
      expiration = 10
    )
  })
  
  shiny::observeEvent(input$cookie_remove, {
    remove_cookie(name = "my_cookie")
  })
  
  output$display_cookie <- renderUI({
    if(!is.null(input$cookies$my_cookie)) {
      shiny::h3("Your cookie:", input$cookies$my_cookie)
    } else {
      shiny::h3("Enter some text.")
    }
  })
}
```

Use `extract_cookie()` to extract the value of a named cookie from the
request object, passed to the ui when a Shiny app loads.

``` r
req <- list(HTTP_COOKIE = "cookie1=expected_value; cookie2=1; cookie3=2")
extract_cookie(req, "cookie1")
#> [1] "expected_value"

ui <- function(request) {
  cookie1 <- extract_cookie(request, "cookie1")
  if (cookie1 == "expected_value") {
    "A ui for the expected value."
  } else {
    "A different ui."
  }
}
ui(req)
#> [1] "A ui for the expected value."
```

## Code of Conduct

Please note that the cookies project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
