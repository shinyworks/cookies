#' Extract an Individual Cookie from a Shiny Request
#'
#' The Shiny request object includes any cookies that are available to the app.
#' This function extracts the value of a named cookie from that request.
#'
#' @inheritParams extract_cookies
#' @param cookie_name The name of the individual cookie to extract.
#'
#' @return The contents of that cookie.
#' @export
#' @examples
#' req <- list(HTTP_COOKIE = "cookie1=expected_value; cookie2=1; cookie3=2")
#' extract_cookie(req, "cookie1")
#' extract_cookie(req, "cookie2")
#' extract_cookie(list(), "cookie1")
#' extract_cookie(NULL, "cookie1")
extract_cookie <- function(request, cookie_name) {
  cookies <- extract_cookies(request = request)

  if (length(cookies) && cookie_name %in% names(cookies)) {
    return(cookies[[cookie_name]])
  } else {
    return(NA_character_)
  }
}

#' Extract All Cookies from a Shiny Request
#'
#' The Shiny request object includes any cookies that are available to the app.
#' This function extracts those cookies as a named list.
#'
#' @param request A shiny request object.
#'
#' @return All cookies in the request, as a list.
#' @export
#' @examples
#' req <- list(HTTP_COOKIE = "cookie1=expected_value; cookie2=1; cookie3=2")
#' extract_cookies(req)
#' extract_cookies(list())
#' extract_cookies(NULL)
extract_cookies <- function(request) {
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
