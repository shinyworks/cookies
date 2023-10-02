test_that("set_cookie works.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      session = session
    )
  )
  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      expiration = 22,
      session = session
    )
  )
  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      expiration = 22,
      secure_only = TRUE,
      domain = "this",
      path = "/docs/",
      same_site = "None",
      session = session
    )
  )
  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      secure_only = FALSE,
      same_site = "None",
      session = session
    ),
    error = TRUE
  )
  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      same_site = "blargh",
      session = session
    ),
    error = TRUE
  )
  expect_snapshot(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      same_site = 1:3,
      session = session
    ),
    error = TRUE
  )
})

test_that("remove_cookie works.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  expect_snapshot(
    remove_cookie("testname", session = session)
  )
})

test_that("get_cookie works.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  session$input <- list(cookies_start = list(key = "value"))
  session$request <- list(HTTP_COOKIE = "key=value")
  expect_identical(
    get_cookie("key", session = session),
    "value"
  )
  session$input <- list(
    cookies = list(key = "value2"),
    cookies_start = list(key = "value2")
  )
  session$input$cookies_ready <- TRUE
  expect_identical(
    get_cookie("key", session = session),
    "value2"
  )
})

test_that("get_cookie works inside modules.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  # When you're in a module, the session is a special session_proxy that has its
  # parent inside of it. Make sure we can still get cookies.
  root_session <- structure(
    list(
      request = list(HTTP_COOKIE = "key=value"),
      input = list(
        cookies = list(
          key = "value",
          key2 = "value2"
        ),
        cookies_start = list(key = "value"),
        cookies_ready = TRUE
      )
    ),
    class = "ShinySession"
  )
  subsession <- structure(
    list(
      parent = root_session,
      overrides = list(
        input = list()
      )
    ),
    class = "session_proxy"
  )
  expect_identical(
    get_cookie("key2", session = subsession),
    "value2"
  )
})

test_that("set_cookie errors appropriately.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  session$input <- list(
    cookies_start = list(normal_cookie = 2)
  )
  session$request <- list(
    HTTP_COOKIE = "http_only_cookie=1; normal_cookie=2"
  )
  expect_error(
    set_cookie("http_only_cookie", session = session),
    class = "error_http_only_js"
  )

  # I'm not going to make the rest work, I just want to make sure I get past the
  # check.
  expect_no_error(
    set_cookie(
      cookie_name = "normal_cookie",
      cookie_value = 3,
      session = session
    )
  )
})

test_that("remove_cookie errors appropriately.", {
  # Stub a session so we can test these outside of shiny.
  session <- structure(list(), class = "ShinySession")
  session$sendCustomMessage <- function(type, message) {
    my_types <- c("cookie-set", "cookie-remove")
    if (!(type %in% my_types)) {
      stop("Bad type.")
    }
    return(
      jsonlite::toJSON(message)
    )
  }

  session$input <- list(
    cookies_start = list(normal_cookie = 2)
  )
  session$request <- list(
    HTTP_COOKIE = "http_only_cookie=1; normal_cookie=2"
  )
  expect_error(
    remove_cookie("http_only_cookie", session = session),
    class = "error_http_only_js"
  )

  expect_no_error(
    remove_cookie("normal_cookie", session = session)
  )
})

test_that(".root_session fails gracefully.", {
  expect_error(
    .root_session(list()),
    "not found"
  )
})
