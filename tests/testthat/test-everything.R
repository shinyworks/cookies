# This was copied directly from {scenes}. I will move things out of here as I
# go.

test_that("set_cookie returns the expected tagList.", {
  expect_snapshot(
    set_cookie(
      contents = "contents of the cookie",
      cookie_name = "name_of_cookie",
      expiration = 27
    )
  )
})
