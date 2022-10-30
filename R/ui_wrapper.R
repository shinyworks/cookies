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
#' @return An object with the same signature as the input `ui`, but with the
#'   dependencies needed to handle cookies. If `ui` is a [shiny::tagList()], a
#'   [shiny::tagList()] will be returned; if `ui` is a function, a function will
#'   be returned.
#' @export
#' @examples
#' str(add_cookie_handlers("example"))
add_cookie_handlers <- function(ui) {
  # The return needs to match the input.

  # Case 1: Don't mess with httpResponse objects.
  if (inherits(ui, "httpResponse")) {
    return(ui)
  }

  # Case 2: Functions depend on whether they're request-handlers or something
  # else.
  if (is.function(ui)) {
    force(ui)
    if (length(formals(ui))) {
      return(
        function(request) {
          ui <- ui(request)
          return(
            shiny::tagList(
              cookie_dependency(),
              ui
            )
          )
        }
      )
    } else {
      return(
        function() {
          shiny::tagList(
            cookie_dependency(),
            ui()
          )
        }
      )
    }
  }

  # Case 3: Simple tagsList-style uis should remain simple.
  return(
    shiny::tagList(
      cookie_dependency(),
      ui
    )
  )
}
