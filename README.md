
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cookies <a href="https://r4ds.github.io/cookies/"><img src="man/figures/logo.svg" align="right" height="424" /></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/cookies)](https://CRAN.R-project.org/package=cookies)
[![Codecov test
coverage](https://codecov.io/gh/r4ds/cookies/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r4ds/cookies?branch=main)
[![R-CMD-check](https://github.com/r4ds/cookies/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r4ds/cookies/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Cookies are name-value pairs that are saved in a user’s browser by a
website. Cookies allow websites to persist information about the user
and their use of the website. The goal of {cookies} it to make it as
easy as possible to use cookies in shiny apps.

## Installation

Install the released version of {cookies} from CRAN:

``` r
install.packages("cookies")
```

Or install the development version of {cookies} from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("r4ds/cookies")
```

## Use Cases

Several potential use cases motivated the creation of this package. Here
I present the key motivating example, to demonstrate how the package
might be useful to you.

### Authentication

The primary motivating use case was authentication. You can see this use
case in action in the [{shinyslack}](https://github.com/r4ds/shinyslack)
package (currently only available via GitHub).

The general strategy is to save an encrypted version of the user’s token
to a cookie. If the cookie exists and is valid, the user sees the site.
If the cookie does not exist, the user is asked to log in. If the url
has the authorization code (a step during oauth authentication), the
code is exchanged for a token, and saved to a cookie.

The switches between the states are facilitated by the
[{scenes}](https://github.com/r4ds/scenes) package (also currently only
available via GitHub).

Here I’ll demonstrate the case where the user has a cookie, and you wish
to use their authentication information to change the display of your
app.

``` r
library(cookies)
library(shiny)

# Shiny UIs can be functions that take a request object as an argument. The
# request contains information about the user who is requesting to view the
# page, including any cookies they provide. Here we look for a cookie named
# "authenticated_name", but in a real use case this would likely be something
# more complex.
ui <- function(request) {
  user_name <- cookies::extract_cookie(
    request, 
    cookie_name = "authenticated_name"
  )

  # We check to see if their cookie is valid. In this toy example, their cookie
  # is valid if the name is in a list of known users.
  if (user_name %in% c("Priyanka", "Yoni", "Jon")) {
    return(main_ui)
  } else {
    return(login_ui)
  }
}

# The main_ui is served if they're authenticated.
main_ui <- cookies::add_cookie_handlers(
  fluidPage(
    titlePanel("Our Real App"),
    sidebarLayout(
      sidebarPanel(
        shiny::p("Inputs or whatnot")
      ),
      mainPanel(
        textOutput("welcome"),
        actionButton("unset", "Delete Cookie"),
        p("Click the button then refresh this page.")
      )
    )
  )
) 

# Otherwise we serve the login_ui.
login_ui <- add_cookie_handlers(
  fluidPage(
    titlePanel("Login"),
    fluidRow(
      textInput("user_name", label = "Type a valid name then refresh this page")
    )
  )
)

# Both uis share a common server function.
server <- function(input, output, session) {
  # Since both UIs are wrapped with add_cookie_handlers, cookies are
  # available in the input object.
  output$welcome <- renderText({
    req(input$cookies$authenticated_name)
    if (!is.null(input$cookies$authenticated_name)) {
      paste("Welcome,", input$cookies$authenticated_name)
    }
  })
  
  observeEvent(
    input$unset,
    cookies::remove_cookie("authenticated_name")
  )
  
  # This server also processes the input from login_ui.
  observeEvent(
    input$user_name,
    cookies::set_cookie(
      cookie_name = "authenticated_name",
      cookie_value = input$user_name
    )
  )
}

shinyApp(
  ui,
  server,
  options = list(
    launch.browser = TRUE
  )
)
```

### Other Use Cases

- Save settings between visits. This can work similar to Shiny’s
  built-in bookmarking, but doesn’t require that the user save a URL to
  reflect the app state.
- Log a datestamp for the user’s visit, to, for example, notify users
  about new features since their last visit.

## Code of Conduct

Please note that the cookies project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
