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
  attributes <- .validate_attributes(
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
#' @param http_only Logical indicating whether the cookie should only be sent as
#'   part of an HTTP request. When this is `FALSE` (default), the cookie is
#'   accessible to JavaScript via the `Document.cookie` property.
#'
#' @return A [shiny::httpResponse()] that sets the cookie.
#' @export
#' @examples
#' set_cookie_response("my_cookie", "contents of my cookie")
#' set_cookie_response("my_cookie", "contents of my cookie", expiration = 10)
set_cookie_response <- function(cookie_name,
                                cookie_value,
                                expiration = 90,
                                secure_only = NULL,
                                domain = NULL,
                                path = NULL,
                                same_site = NULL,
                                http_only = FALSE) {
  # The main differences between this and set_cookie_on_load are that this
  # allows http_only, but it doesn't use the javascript so we need to translate
  # the expiration ourselves. And of course this is effectively a dead end, and
  # should be used in combination with something that will load an actual ui if
  # the cookie is already set.
  stop("This is still a mess!")
  stop("Also, update all the help to match the tidyverse style guide!")

  attributes <- .validate_attributes(
    expiration = expiration,
    secure_only = secure_only,
    domain = domain,
    path = path,
    same_site = same_site
  )
  attributes <- .shiny_toJSON(attributes)


  shiny::httpResponse(
    headers = c(
      "Set-cookie: <cookie-name>=<cookie-value>; Expires=<date>",
      "Set-cookie: <cookie-name2>=<cookie-value>; Expires=<date>"
    ),
    content = "Your cookie is set."
  )

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
