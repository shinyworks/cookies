test_that("set_cookie_on_load returns the expected tagList.", {
  expect_snapshot(
    set_cookie_on_load(
      name = "name_of_cookie",
      contents = "contents of the cookie"
    )
  )
  expect_snapshot(
    set_cookie_on_load(
      name = "name_of_cookie",
      contents = "contents of the cookie",
      expiration = 27
    )
  )
})
