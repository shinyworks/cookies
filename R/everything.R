# This was copied directly from {scenes}. I will move things out of here as I
# go.

# cookies in requests ----------------------------------------------------------

# These take request as an argument.

#' Extract an Individual Cookie from a Shiny Request
#'
#' @inheritParams .extract_cookies
#' @param cookie_name The name of the individual cookie to extract.
#'
#' @return The contents of that cookie.
#' @keywords internal
.extract_cookie <- function(request, cookie_name) {
  cookies <- .extract_cookies(request = request)

  if (length(cookies) && cookie_name %in% names(cookies)) {
    return(cookies[[cookie_name]])
  } else {
    return(NA_character_)
  }
}

#' Extract All Cookies from a Shiny Request
#'
#' @param request A shiny request object.
#'
#' @return All cookies in the request, as a list.
#' @keywords internal
.extract_cookies <- function(request) {
  cookies <- request$HTTP_COOKIE

  # Based on shiny::parseQueryString
  if (is.null(cookies) || nchar(cookies) == 0) {
    return(NULL)
  }
  pairs <- strsplit(cookies, "; ", fixed = TRUE)[[1]]
  pairs <- pairs[pairs != ""]
  pairs <- strsplit(pairs, "=", fixed = TRUE)
  keys <- vapply(pairs, function(x) x[1], FUN.VALUE = character(1))
  values <- vapply(pairs, function(x) x[2], FUN.VALUE = character(1))
  values[is.na(values)] <- ""
  keys <- gsub("+", " ", keys, fixed = TRUE)
  values <- gsub("+", " ", values, fixed = TRUE)
  keys <- httpuv::decodeURIComponent(keys)
  values <- httpuv::decodeURIComponent(values)
  res <- stats::setNames(as.list(values), keys)
  return(res)
}


# cookies in JS/HTML -----------------------------------------------------------

#' Attach the js-cookie Javascript Library for Shiny
#'
#' Add the js-cookie Javascript library as an HTML dependency, and make cookies
#' available in the Shiny input object.
#'
#' Note that this function is currently exported from this package, but the
#' intention is to move all cookie handling to a separate package.
#'
#' @return An [htmltools::htmlDependency()], which Shiny uses to add the
#'   js-cookie Javascript library exactly once.
#' @export
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
#' Note that this function is currently exported from this package, but the
#' intention is to move all cookie handling to a separate package.
#'
#' @param ui A 0- or 1-argument function defining the UI of a Shiny app, or a
#'   [shiny::tagList()].
#'
#' @return A function that takes a request and a [shiny::tagList()]that includes
#'   the dependencies needed to handle cookies.
#' @export
add_cookie_javascript <- function(ui) {
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
