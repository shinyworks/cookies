#' Attach the js-cookie Javascript Library for Shiny
#'
#' Add the js-cookie Javascript library as an HTML dependency, and make cookies
#' available in the Shiny input object.
#'
#' @return An [htmltools::htmlDependency()], which Shiny uses to add the
#'   js-cookie Javascript library exactly once.
#' @export
#' @examples
#' cookie_dependency()
cookie_dependency <- function() {
  return(
    htmltools::htmlDependency(
      name = "shinycookie",
      version = "1.0.0",
      src = "js",
      package = "cookies",
      script = c("js.cookie.js", "cookie_input.js")
    )
  )
}

#' Add Cookies to an Existing Shiny UI
#'
#' Wrap a Shiny ui in this function in order to add cookie-handling
#' functionality.
#'
#' @param ui A 0- or 1-argument function defining the UI of a Shiny app, or a
#'   [shiny::tagList()].
#'
#' @return A function that takes a request and a [shiny::tagList()] that
#'   includes the dependencies needed to handle cookies.
#' @export
#' @examples
#' str(add_cookie_handlers("example"))
add_cookie_handlers <- function(ui) {
  force(ui)
  return(
    function(request) {
      # ui can be a tagList, a 0-argument function, or a 1-argument function.
      # Deal with those.
      if (is.function(ui)) {
        if (length(formals(ui))) {
          ui <- ui(request)
        } else {
          ui <- ui()
        }
      }
      return(
        shiny::tagList(
          cookie_dependency(),
          ui
        )
      )
    }
  )
}
