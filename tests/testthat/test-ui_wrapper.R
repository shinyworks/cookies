test_that("cookie_dependency returns the expected object.", {
  expect_snapshot(cookie_dependency())
})

test_that("add_cookie_handlers adds js to shiny-like things.", {
  test_fn <- add_cookie_handlers("test")
  test_result <- test_fn()
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])

  test_fancy <- function(request) {
    length(request)
  }
  test_fn <- add_cookie_handlers(test_fancy)
  test_result <- test_fn(list(a = 1, b = 2))
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])

  test_fancy <- function() {
    "test"
  }
  test_fn <- add_cookie_handlers(test_fancy)
  test_result <- test_fn(list(a = 1, b = 2))
  expect_length(test_result, 2)
  expect_snapshot(test_result[[1]])
  expect_snapshot(test_result[[2]])
})

