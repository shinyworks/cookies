# cookie_dependency returns the expected object.

    Code
      cookie_dependency()
    Output
      [[1]]
      List of 10
       $ name      : chr "jscookie"
       $ version   : chr "1.0.0"
       $ src       :List of 2
        ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "js.cookie.min.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"
      
      [[2]]
      List of 10
       $ name      : chr "cookie_input"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "cookie_input.js"
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
      [[1]]
      List of 10
       $ name      : chr "jscookie"
       $ version   : chr "1.0.0"
       $ src       :List of 2
        ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "js.cookie.min.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"
      
      [[2]]
      List of 10
       $ name      : chr "cookie_input"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "cookie_input.js"
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
      [[1]]
      List of 10
       $ name      : chr "jscookie"
       $ version   : chr "1.0.0"
       $ src       :List of 2
        ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "js.cookie.min.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"
      
      [[2]]
      List of 10
       $ name      : chr "cookie_input"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "cookie_input.js"
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
      [[1]]
      List of 10
       $ name      : chr "jscookie"
       $ version   : chr "1.0.0"
       $ src       :List of 2
        ..$ href: chr "https://cdn.jsdelivr.net/npm/js-cookie/dist/"
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "js.cookie.min.js"
       $ stylesheet: NULL
       $ head      : NULL
       $ attachment: NULL
       $ package   : chr "cookies"
       $ all_files : logi TRUE
       - attr(*, "class")= chr "html_dependency"
      
      [[2]]
      List of 10
       $ name      : chr "cookie_input"
       $ version   : chr "1.0.0"
       $ src       :List of 1
        ..$ file: chr "js"
       $ meta      : NULL
       $ script    : chr "cookie_input.js"
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

