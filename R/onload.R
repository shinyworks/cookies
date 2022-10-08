#' Shiny Tag to Add Cookies on Page Load
#'
#' Generates javascript which will set a cookie in the user's browser when the
#' Shiny app first loads.
#'
#' @param cookie_name A name for the cookie. Must be a valid cookie name.
#' @param contents The contents of the cookie as a single character value.
#' @param expiration Days after which the cookie should expire.
#'
#' @return A [shiny::tagList()] that provides the HTML and javascript to set the
#'   cookie.
#' @export
#' @examples
#' set_cookie_on_load("my_cookie", "contents of my cookie")
#' set_cookie_on_load("my_cookie", "contents of my cookie", expiration = 10)
set_cookie_on_load <- function(cookie_name, contents, expiration = 90) {
  return(
    shiny::tagList(
      cookie_dependency(),
      shiny::tags$script(
        shiny::HTML(
          sprintf(
            "Cookies.set('%s', '%s', { expires: %i });",
            cookie_name,
            contents,
            expiration
          )
        )
      )
    )
  )
}
