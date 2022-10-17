#' Shiny tag to add cookies on page load
#'
#' Generate a [shiny::tagList()] which uses JavaScript to set a cookie in the
#' user's browser when the shiny app loads.
#'
#' @inheritParams .shared-parameters
#'
#' @return A [shiny::tagList()] that provides the HTML and javascript to set the
#'   cookie.
#' @export
#' @examples
#' set_cookie_on_load("my_cookie", "contents of my cookie")
#' set_cookie_on_load("my_cookie", "contents of my cookie", expiration = 10)
set_cookie_on_load <- function(cookie_name,
                               cookie_value,
                               expiration = 90,
                               secure_only = NULL,
                               domain = NULL,
                               path = NULL,
                               same_site = NULL) {
  attributes <- .javascript_attributes(
    expiration = expiration,
    secure_only = secure_only,
    domain = domain,
    path = path,
    same_site = same_site
  )
  attributes <- .shiny_toJSON(attributes)
  return(
    shiny::tagList(
      cookie_dependency(),
      shiny::tags$script(
        shiny::HTML(
          sprintf(
            'Cookies.set("%s", "%s", %s);',
            cookie_name,
            cookie_value,
            attributes
          )
        )
      )
    )
  )
}


#' Set cookie via HTTP header
#'
#' Send a [shiny::httpResponse()] that sets a cookie in the user's browser. Note
#' that this does *not* return a full shiny ui.
#'
#' @inheritParams .shared-parameters
#' @param redirect A relative or absolute URL where the user should be sent
#'   next. A typical case would be the same URL minus the query parameter that
#'   triggered the Set-cookie response.
#' @inheritParams shiny::httpResponse
#' @param ... Additional parameters passed on to [shiny::httpResponse()].
#'
#' @return A [shiny::httpResponse()] that sets the cookie.
#' @export
#' @examples
#' set_cookie_response("my_cookie", "contents of my cookie")
#' set_cookie_response("my_cookie", "contents of my cookie", expiration = 10)
#' set_cookie_response(
#'   "my_cookie", "contents of my cookie", content = "Your cookie is set."
#' )
#' set_cookie_response(
#'   "my_cookie", "contents of my cookie", redirect = "/"
#' )
set_cookie_response <- function(cookie_name,
                                cookie_value,
                                expiration = 90,
                                secure_only = NULL,
                                domain = NULL,
                                path = NULL,
                                same_site = NULL,
                                http_only = FALSE,
                                redirect = NULL,
                                ...) {
  headers <- list(
    `Set-cookie` = .http_cookie_string(
      cookie_name = cookie_name,
      cookie_value = cookie_value,
      expiration = expiration,
      secure_only = secure_only,
      domain = domain,
      path = path,
      same_site = same_site,
      http_only = http_only
    )
  )

  dots <- rlang::list2(...)

  status <- dots$status %||% 200L

  if (!is.null(redirect)) {
    headers <- c(
      headers,
      Location = redirect
    )
    status <- dots$status %||% 302L

    if (floor(status/100) != 3) {
      cli::cli_warn(
        c(
          "Unexpected status code.",
          x = "Status code {status} provided, expected 300 to 399."
        )
      )
    }
  }

  dots$status <- status

  return(
    rlang::exec(
      shiny::httpResponse,
      headers = headers,
      !!!dots
    )
  )
}
