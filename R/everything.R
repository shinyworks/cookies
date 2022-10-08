# This was copied directly from {scenes}. I will move things out of here as I
# go.


# cookies in JS/HTML -----------------------------------------------------------

#' Shiny Tags to Add Cookies
#'
#' This function generates javascript which will set a cookie in the user's
#' browser.
#'
#' Note that this function is currently exported from this package, but the
#' intention is to move all cookie handling to a separate package.
#'
#' @param contents The contents of the cookie. Right now this should be a single
#'   character value.
#' @param cookie_name A name for the cookie. Must be a valid cookie name.
#' @param expiration Days after which the cookie should expire.
#'
#' @return A [shiny::tagList()] that provides the HTML and javascript to set the
#'   cookie.
#' @export
set_cookie <- function(contents, cookie_name, expiration = 90) {
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
