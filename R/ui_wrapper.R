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
    list(
      htmltools::htmlDependency(
        name = "jscookie",
        version = "1.0.0",
        src = c(
          href = "https://cdn.jsdelivr.net/npm/js-cookie/dist/",
          file = "js"
        ),
        package = "cookies",
        script = "js.cookie.min.js"
      ),
      htmltools::htmlDependency(
        name = "cookie_input",
        version = "1.0.0",
        src = "js",
        package = "cookies",
        script = "cookie_input.js"
      )
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
  UseMethod("add_cookie_handlers")
}

#' @export
add_cookie_handlers.default <- function(ui) {
  return(
    shiny::tagList(
      cookie_dependency(),
      ui
    )
  )
}

#' @export
add_cookie_handlers.httpResponse <- function(ui) {
  # Don't mess with things that are already httpResponses.
  return(ui)
}

#' @export
add_cookie_handlers.function <- function(ui) {
  # For functions we need to return a function, which does our thing then
  # carries on with whatever the function originally did.
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
