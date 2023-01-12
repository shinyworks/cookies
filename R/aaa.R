#' Parameters used in multiple functions
#'
#' These are parameters that are likely to show up in multiple functions, so I
#' gather their definitions in one easy-to-find place.
#'
#' @param attributes A list with values for `expiration`, `secure_only`,
#'   `domain`, `path`, `same_site`, and `http_only`
#' @param cookie_name The name of the cookie. Can contain any US-ASCII
#'   characters except for: the control character, space, a tab, or separator
#'   characters like ( ) < > @ , ; : \\ " / \[ \] ? = \{ \}.
#' @param cookie_value The contents of the cookie as a single character value.
#' @param domain The host to which the cookie will be sent (including
#'   subdomains). If this is `NULL` (default) the cookie will only be sent to
#'   the host of the page where this cookie was set (not including subdomains).
#' @param expiration Days after which the cookie should expire. To remove an
#'   HttpOnly cookie, send a negative value for this attribute.
#' @param http_only Logical indicating whether the cookie should only be sent as
#'   part of an HTTP request. When this is `FALSE` (default), the cookie is
#'   accessible to JavaScript via the `Document.cookie` property.
#' @param path The path that must exist in the requested URL for the browser to
#'   send this cookie. Includes subdirectories.
#' @param same_site One of "strict", "lax" (default), or "none", indicating when
#'   the cookie should be sent. When `same_site = "none"`, `secure_only` must be
#'   `TRUE`.
#' @param secure_only Logical indicating whether the cookie should only be
#'   accessible via secure (`https:`) requests (except on localhost).
#' @param session Shiny session in which the cookies can be found (the default
#'   should probably always be used).
#' @param ui A 0- or 1-argument function defining the ui of a shiny app, or a
#'   [shiny::tagList()].
#'
#' @name .shared-parameters
#' @keywords internal
NULL
