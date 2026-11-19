# .pkg_abort works

    Code
      .pkg_abort("This is a test error", c("subclass", "test_error"))
    Condition <cookies-error-subclass-test_error>
      Error:
      ! This is a test error

# .pkg_warn works

    Code
      .pkg_warn("This is a test warning", c("subclass", "test_warning"))
    Condition <cookies-warning-subclass-test_warning>
      Warning:
      This is a test warning

# .pkg_inform works

    Code
      .pkg_inform("This is a test message", c("subclass", "test_message"))
    Message <cookies-message-subclass-test_message>
      This is a test message

