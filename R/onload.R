#' Shiny Tag to Add Cookies on Page Load
#'
#' Generates javascript which will set a cookie in the user's browser when the
#' Shiny app first loads.
#'
#' @inheritParams .shared-parameters
#'
#' @return A [shiny::tagList()] that provides the HTML and javascript to set the
#'   cookie.
#' @export
#' @examples
#' set_cookie_on_load("my_cookie", "contents of my cookie")
#' set_cookie_on_load("my_cookie", "contents of my cookie", expiration = 10)
set_cookie_on_load <- function(name,
                               contents,
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
            name,
            contents,
            attributes
          )
        )
      )
    )
  )
}
