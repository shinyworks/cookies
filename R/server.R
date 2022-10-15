#' Create or update a cookie
#'
#' Instruct the user's browser to create a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#' @inheritParams shiny::moduleServer
#'
#' @export
set_cookie <- function(cookie_name,
                       cookie_value,
                       expiration = 90,
                       secure_only = NULL,
                       domain = NULL,
                       path = NULL,
                       same_site = NULL,
                       session = shiny::getDefaultReactiveDomain()) {
  # This sets via javascript. When we add HttpOnly handling, this should either
  # deal with that or error if they try to do http_only.

  attributes <- .validate_attributes(
    expiration = expiration,
    secure_only = secure_only,
    domain = domain,
    path = path,
    same_site = same_site
  )

  session$sendCustomMessage(
    "cookie-set",
    list(
      name = cookie_name,
      value = cookie_value,
      attributes = attributes
    )
  )
}

#' Remove a cookie
#'
#' Instruct the user's browser to remove a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#' @inheritParams shiny::moduleServer
#'
#' @export
remove_cookie <- function(cookie_name,
                          session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    "cookie-remove",
    list(name = cookie_name)
  )
}
