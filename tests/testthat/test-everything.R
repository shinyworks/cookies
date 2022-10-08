# This was copied directly from {scenes}. I will move things out of here as I
# go.

test_that(".extract_cookie works", {
  # Set up a bunch of requests.
  req_missing <- list()
  req_empty <- list(HTTP_COOKIE = NULL)
  req_other <- list(HTTP_COOKIE = "other=1; other2=2")
  req_only_test <- list(HTTP_COOKIE = "testcookie=expected_value")
  req_test_1 <- list(
    HTTP_COOKIE = "testcookie=expected_value; other=1; other2=2"
  )
  req_test_2 <- list(
    HTTP_COOKIE = "other=1; testcookie=expected_value; other2=2"
  )
  req_test_3 <- list(
    HTTP_COOKIE = "other=1; other2=2; testcookie=expected_value"
  )
  req_test_bad <- list(HTTP_COOKIE = "testcookie=bad_value")

  expect_identical(
    .extract_cookie(req_missing, "testcookie"),
    NA_character_
  )
  expect_identical(
    .extract_cookie(req_empty, "testcookie"),
    NA_character_
  )
  expect_identical(
    .extract_cookie(req_other, "testcookie"),
    NA_character_
  )
  expect_identical(
    .extract_cookie(req_only_test, "testcookie"),
    "expected_value"
  )
  expect_identical(
    .extract_cookie(req_test_1, "testcookie"),
    "expected_value"
  )
  expect_identical(
    .extract_cookie(req_test_2, "testcookie"),
    "expected_value"
  )
  expect_identical(
    .extract_cookie(req_test_3, "testcookie"),
    "expected_value"
  )
  expect_identical(
    .extract_cookie(req_test_bad, "testcookie"),
    "bad_value"
  )
})

test_that("cookie_dependency returns the expected object.", {
  expect_snapshot(cookie_dependency())
})

test_that("add_cookie_javascript adds js to shiny-like things.", {
  test_fn <- add_cookie_javascript("test")
  test_result <- test_fn()
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])

  test_fancy <- function(request) {
    length(request)
  }
  test_fn <- add_cookie_javascript(test_fancy)
  test_result <- test_fn(list(a = 1, b = 2))
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])

  test_fancy <- function() {
    "test"
  }
  test_fn <- add_cookie_javascript(test_fancy)
  test_result <- test_fn(list(a = 1, b = 2))
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])
})

test_that("set_cookie returns the expected tagList.", {
  expect_snapshot(
    set_cookie(
      contents = "contents of the cookie",
      cookie_name = "name_of_cookie",
      expiration = 27
    )
  )
})
