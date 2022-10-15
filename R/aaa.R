#' Parameters used in multiple functions
#'
#' @param cookie_value The contents of the cookie as a single character value.
#' @param domain The host to which the cookie will be sent (including
#'   subdomains). If this is `NULL` (default) the cookie will only be sent to
#'   the host of the page where this cookie was set (not including subdomains).
#' @param expiration Days after which the cookie should expire.
#' @param cookie_name The name of the cookie. Can contain any US-ASCII
#'   characters except for: the control character, space, a tab, or separator
#'   characters like ( ) < > @ , ; : \\ " / \[ \] ? = \{ \}.
#' @param path The path that must exist in the requested URL for the browser to
#'   send this cookie. Includes subdirectories.
#' @param same_site One of "strict", "lax" (default), or "none", indicating when
#'   the cookie should be sent. When `same_site = "none"`, `secure_only` must be
#'   `TRUE`.
#' @param secure_only Logical indicating whether the cookie should only be
#'   accessible via secure (`https:`) requests (except on localhost).
#' @param ui A 0- or 1-argument function defining the ui of a shiny app, or a
#'   [shiny::tagList()].
#'
#' @name .shared-parameters
#' @keywords internal
NULL

#' Ensure cookie attributes are valid
#'
#' @inheritParams .shared-parameters
#'
#' @return A list of attributes.
#' @keywords internal
.validate_attributes <- function(expiration,
                                 secure_only,
                                 domain,
                                 path,
                                 same_site) {
  same_site <- .validate_same_site(same_site, secure_only)
  attributes <- list(
    expires = expiration,
    secureOnly = secure_only,
    domain = domain,
    path = path,
    sameSite = same_site
  )
  # I don't want to trust that the JS handles NULLs cleanly.
  attributes[vapply(attributes, is.null, logical(1))] <- NULL
  return(attributes)
}

#' Ensure same_site is valid
#'
#' @inheritParams .shared-parameters
#'
#' @return One of `NULL`, "Strict", "Lax", or "None".
#' @keywords internal
.validate_same_site <- function(same_site, secure_only) {
  if (is.null(same_site)) {
    return(same_site)
  }

  if (length(same_site) != 1) {
    stop("same_site must be a length-1 character or NULL.")
  }

  # Capitalize only the first letter.
  same_site <- gsub("^(.)", "\\U\\1\\E", tolower(same_site), perl = TRUE)

  if (!(same_site %in% c("Strict", "Lax", "None"))) {
    stop("same_site must be one of Strict, Lax, or None.")
  }

  if (same_site == "None" && !isTRUE(secure_only)) {
    stop("When same_site is None, secure_only must be TRUE.")
  }

  return(same_site)
}


#' Prep data for javascript
#'
#' This is an unexported function in shiny, and has been directly copy/pasted
#' (other than the name and documentation). This function formats things in the
#' way shiny's JS functions expect.
#'
#' @inheritParams jsonlite::toJSON
#' @inheritDotParams jsonlite::toJSON
#' @param use_signif Passed on to a print method.
#' @param UTC Passed on to a print method.
#' @param rownames Passed on to a print method.
#' @param keep_vec_names Passed on to a print method.
#' @param strict_atomic Used to deal with atomic vectors and/or unboxing.
#'
#' @return Jsonified text.
#' @keywords internal
.shiny_toJSON <- function(x, ..., dataframe = "columns", null = "null",
                          na = "null", auto_unbox = TRUE,
                          digits = getOption("shiny.json.digits", 16),
                          use_signif = TRUE, force = TRUE, POSIXt = "ISO8601",
                          UTC = TRUE, rownames = FALSE, keep_vec_names = TRUE,
                          strict_atomic = TRUE) {
  if (strict_atomic) {
    x <- I(x)
  }

  # I(x) is so that length-1 atomic vectors get put in [].
  jsonlite::toJSON(x,
    dataframe = dataframe, null = null, na = na,
    auto_unbox = auto_unbox, digits = digits,
    use_signif = use_signif, force = force, POSIXt = POSIXt,
    UTC = UTC, rownames = rownames,
    keep_vec_names = keep_vec_names, json_verbatim = TRUE, ...
  )
}
