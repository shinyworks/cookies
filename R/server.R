#' Create or update a cookie
#'
#' Instruct the user's browser to create a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#'
#' @return A call to `session$sendCustomMessage()` which sets the targeted
#'   cookie.
#' @export
#' @examples
#' server <- function(input, output, server) {
#'   shiny::observeEvent(
#'     input$button_that_sets_cookie,
#'     set_cookie(
#'       "my_cookie",
#'       "the value of this cookie"
#'     )
#'   )
#' }
set_cookie <- function(cookie_name,
                       cookie_value,
                       expiration = 90,
                       secure_only = NULL,
                       domain = NULL,
                       path = NULL,
                       same_site = NULL,
                       session = shiny::getDefaultReactiveDomain()) {
  # When the app first loads, you might get a weird race condition where the
  # input isn't populated yet, so even normal cookies look like http-only
  # cookies.
  if (.is_http_only(cookie_name, session)) {
    cli::cli_abort(
      c(
        x = "Cannot update cookie {cookie_name}.",
        i = "HttpOnly cookies can only be updated via set_cookie_response()."
      ),
      class = "error_http_only_js"
    )
  }

  attributes <- .javascript_attributes(
    expiration = expiration,
    secure_only = secure_only,
    domain = domain,
    path = path,
    same_site = same_site
  )

  # Create an observer to fail if the cookie fails to save. This should never
  # happen but maybe they don't have write access or something similarly weird.
  shiny::observeEvent( # nocov start
    .root_session(session)$input$cookie_set_error,
    cli::cli_abort(.root_session(session)$input$cookie_set_error),
    ignoreInit = TRUE,
    once = TRUE
  ) # nocov end

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
#'
#' @return A call to `session$sendCustomMessage()` which removes the targeted
#'   cookie.
#' @export
#' @examples
#' server <- function(input, output, server) {
#'   shiny::observeEvent(
#'     input$button_that_removes_cookie,
#'     remove_cookie("my_cookie")
#'   )
#' }
remove_cookie <- function(cookie_name,
                          session = shiny::getDefaultReactiveDomain()) {
  if (.is_http_only(cookie_name, session)) {
    cli::cli_abort(
      c(
        x = "Cannot remove cookie {cookie_name}.",
        i = "HttpOnly cookies can only be updated via set_cookie_response()."
      ),
      class = "error_http_only_js"
    )
  }

  # Create an observer to fail if the cookie fails to be removed. This should
  # never happen but maybe they don't have write access or something similarly
  # weird.
  shiny::observeEvent( # nocov start
    .root_session(session)$input$cookie_remove_error,
    cli::cli_abort(
      c(
        x = .root_session(session)$input$cookie_remove_error
      )
    ),
    ignoreInit = TRUE,
    once = TRUE
  ) # nocov end

  session$sendCustomMessage(
    "cookie-remove",
    list(name = cookie_name)
  )
}

#' Read a cookie
#'
#' Read a cookie from the input object.
#'
#' @inheritParams .shared-parameters
#' @param missing The value to return if the requested cookie does not exist.
#' Defaults to NULL.
#'
#' @return A character with the value of the cookie.
#' @export
#' @examples
#' server <- function(input, output, session) {
#'   get_cookie("my_cookie")
#' }
get_cookie <- function(cookie_name,
                       missing = NULL,
                       session = shiny::getDefaultReactiveDomain()) {
  # The values we need are stored in the root session.
  session <- .root_session(session)

  # When the app first loads, you might get a weird race condition where the
  # input isn't populated yet, so you need to use the request object even for
  # normal cookies.
  if (
    .is_http_only(cookie_name, session) ||
      !(isTRUE(session$cookies_ready))
  ) {
    return(extract_cookie(session$request, cookie_name, missing))
  } else {
    # Once the cookies are initialized, use the input value (even if there isn't
    # a value for this cookie) for non-http-only cookies.
    return(session$input[[paste0("cookie_", cookie_name)]] %||% missing)
  }
}

#' Find the main session
#'
#' This function escapes from a module (or submodule, etc) to find the root
#' session.
#'
#' @param session A session object. Probably always use the default.
#'
#' @return The first session that isn't a "session_proxy".
#' @keywords internal
.root_session <- function(session = shiny::getDefaultReactiveDomain()) {
  # Some hardening of this was inspired by the unexported function
  # find_ancestor_session() in shiny.
  depth <- 20L
  while (inherits(session, "session_proxy") && depth > 0) {
    session <- .subset2(session, "parent")
    depth <- depth - 1L
  }
  if (inherits(session, "ShinySession")) {
    return(session)
  } else {
    stop("Root session not found.")
  }
}

#' Is this cookie HttpOnly?
#'
#' HttpOnly cookies can't be manipulated via javascript.
#'
#' @inheritParams .shared-parameters
#' @param cookie_name The cookie to check.
#'
#' @return A logical indicating whether `cookie_name` is http-only.
#' @keywords internal
.is_http_only <- function(cookie_name,
                          session = shiny::getDefaultReactiveDomain()) {
  session <- .root_session(session)

  # If the input$cookies_start object hasn't initialized yet, we can't do this
  # check properly, so we assume it isn't http-only.
  if (
    "input" %in% names(session) && "cookies_start" %in% names(session$input)
  ) {
    # A cookie can be assumed to be http_only if it was in the request, but was
    # NOT in the initial cookies detected by javascript.
    starting_cookies <- names(session$input$cookies_start)
    req_cookies <- names(extract_cookies(session$request))
    http_only_cookies <- setdiff(req_cookies, starting_cookies)
    return(cookie_name %in% http_only_cookies)
  }

  return(FALSE)
}
