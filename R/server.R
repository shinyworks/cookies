# I thought these were going to be modules, but it's just a pair of functions
# that you can call from other things, I think.

#' Create or Update a Cookie
#'
#' Instruct the user's browser to create a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#' @inheritParams shiny::moduleServer
#'
#' @export
set_cookie <- function(name,
                       contents,
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
      name = name,
      value = contents,
      attributes = attributes
    )
  )
}

#' Remove a Cookie
#'
#' Instruct the user's browser to remove a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#' @inheritParams shiny::moduleServer
#'
#' @export
remove_cookie <- function(name,
                          session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    "cookie-remove",
    list(name = name)
  )
}
