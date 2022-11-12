test_that("extract_cookie works", {
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
    extract_cookie(req_missing, "testcookie"),
    NULL
  )
  expect_identical(
    extract_cookie(req_missing, "testcookie", NA_character_),
    NA_character_
  )
  expect_identical(
    extract_cookie(req_missing, "testcookie", "special default"),
    "special default"
  )
  expect_identical(
    extract_cookie(req_empty, "testcookie"),
    NULL
  )
  expect_identical(
    extract_cookie(req_other, "testcookie"),
    NULL
  )
  expect_identical(
    extract_cookie(req_only_test, "testcookie"),
    "expected_value"
  )
  expect_identical(
    extract_cookie(req_only_test, "testcookie", NA_character_),
    "expected_value"
  )
  expect_identical(
    extract_cookie(req_test_1, "testcookie"),
    "expected_value"
  )
  expect_identical(
    extract_cookie(req_test_2, "testcookie"),
    "expected_value"
  )
  expect_identical(
    extract_cookie(req_test_3, "testcookie"),
    "expected_value"
  )
  expect_identical(
    extract_cookie(req_test_bad, "testcookie"),
    "bad_value"
  )
})
