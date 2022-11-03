# Stub a session so we can test these outside of shiny.
session <- list()
session$sendCustomMessage <- function(type, message) {
  my_types <- c("cookie-set", "cookie-remove")
  if (!(type %in% my_types)) {
    stop("Bad type.")
  }
  return(
    jsonlite::toJSON(message)
  )
}

test_that("set_cookie works.", {
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
  expect_error(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      secure_only = FALSE,
      same_site = "None",
      session = session
    ),
    "secure_only must be TRUE"
  )
  expect_error(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      same_site = "blargh",
      session = session
    ),
    "must be one of Strict"
  )
  expect_error(
    set_cookie(
      cookie_name = "testname",
      cookie_value = "test contents",
      same_site = 1:3,
      session = session
    ),
    "must be a length-1 character or NULL"
  )
})

test_that("remove_cookie works.", {
  expect_snapshot(
    remove_cookie("testname", session = session)
  )
})

test_that("get_cookie works.", {
  session$input <- list()
  session$request <- list(HTTP_COOKIE = "key=value")
  expect_identical(
    get_cookie("key", session = session),
    "value"
  )
  session$input <- list(cookies = list(key = "value2"))
  expect_identical(
    get_cookie("key", session = session),
    "value2"
  )
})
