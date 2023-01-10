#' Create or update a cookie
#'
#' Instruct the user's browser to create a cookie via JavaScript.
#'
#' @inheritParams .shared-parameters
#' @inheritParams shiny::moduleServer
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
  attributes <- .javascript_attributes(
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
#' @inheritParams shiny::moduleServer
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
  # Once the cookies are initialized, use the input value.
  if ("cookies" %in% names(session$input)) {
    session$input$cookies[[cookie_name]] %||% missing
  } else {
    # But, when the app first loads, you might get a weird race condition where
    # the input isn't populate yet.
    extract_cookie(session$request, cookie_name, missing)
  }
}
