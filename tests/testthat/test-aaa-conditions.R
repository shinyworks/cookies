test_that(".pkg_abort works", {
  stbl::expect_pkg_error_snapshot(
    .pkg_abort("This is a test error", c("subclass", "test_error")),
    "cookies",
    "subclass",
    "test_error"
  )
})

test_that(".pkg_warn works", {
  stbl::expect_pkg_warning_snapshot(
    .pkg_warn("This is a test warning", c("subclass", "test_warning")),
    "cookies",
    "subclass",
    "test_warning"
  )
})

test_that(".pkg_inform works", {
  stbl::expect_pkg_message_snapshot(
    .pkg_inform("This is a test message", c("subclass", "test_message")),
    "cookies",
    "subclass",
    "test_message"
  )
})
