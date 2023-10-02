test_that("set_cookie_on_load returns the expected tagList.", {
  expect_snapshot(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie"
    )
  )
  expect_snapshot(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      expiration = 27
    )
  )
})

test_that("Bad attributes throw errors.", {
  expect_snapshot_error(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      expiration = 1:3
    )
  )

  expect_snapshot_error(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      secure_only = 1:3
    )
  )

  expect_snapshot_error(
    set_cookie_response(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      http_only = 1:3
    )
  )

  expect_snapshot_error(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      domain = 1:3
    )
  )

  expect_snapshot_error(
    set_cookie_on_load(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      path = 1:3
    )
  )
})

test_that("set_cookie_response works as expected.", {
  # Exact times change, so we need to deal with the expires bit.
  with_time <- set_cookie_response(
    cookie_name = "name_of_cookie",
    cookie_value = "contents of the cookie"
  )
  expect_s3_class(with_time, "httpResponse")
  with_time_header_set <- sub(
    "Expires=.*$",
    "TIMESTAMP",
    with_time$headers$`Set-cookie`
  )
  expected_string <- "name_of_cookie=contents%20of%20the%20cookie; TIMESTAMP"
  expect_match(
    with_time_header_set,
    expected_string
  )

  expect_snapshot(
    set_cookie_response(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      expiration = NULL
    )
  )
  expect_snapshot(
    set_cookie_response(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      http_only = TRUE,
      expiration = NULL
    )
  )
  expect_snapshot(
    set_cookie_response(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      http_only = TRUE,
      expiration = NULL,
      redirect = "/"
    )
  )
  expect_snapshot(
    set_cookie_response(
      cookie_name = "name_of_cookie",
      cookie_value = "contents of the cookie",
      http_only = TRUE,
      expiration = NULL,
      redirect = "/",
      status = 200L
    )
  )
})
