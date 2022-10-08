# cookie_dependency returns the expected object.

    Code
      cookie_dependency()
    Output
      List of 10
       $ name      : chr "shinycookie"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr [1:2] "js.cookie.js" "cookie_input.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"

# add_cookie_handlers adds js to shiny-like things.

    Code
      test_result[[1]]
    Output
      List of 10
       $ name      : chr "shinycookie"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr [1:2] "js.cookie.js" "cookie_input.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"

---

    Code
      test_result[[2]]
    Output
      [1] "test"

---

    Code
      test_result[[1]]
    Output
      List of 10
       $ name      : chr "shinycookie"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr [1:2] "js.cookie.js" "cookie_input.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"

---

    Code
      test_result[[2]]
    Output
      [1] 2

---

    Code
      test_result[[1]]
    Output
      List of 10
       $ name      : chr "shinycookie"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr [1:2] "js.cookie.js" "cookie_input.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"

---

    Code
      test_result[[2]]
    Output
      [1] "test"

