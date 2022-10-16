#' Attach the js-cookie javascript library for shiny
#'
#' Add the js-cookie Javascript library as an HTML dependency, and make cookies
#' available in the shiny input object.
#'
#' @return An [htmltools::htmlDependency()], which shiny uses to add the
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

#' Add cookies to an existing shiny ui
#'
#' Wrap a shiny ui in this function in order to add cookie-handling
#' functionality.
#'
#' @inheritParams .shared-parameters
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
