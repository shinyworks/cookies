# set_cookie_on_load returns the expected tagList.

    Code
      set_cookie_on_load(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie")
    Output
      <script>Cookies.set("name_of_cookie", "contents of the cookie", {"expires":90});</script>

---

    Code
      set_cookie_on_load(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie",
        expiration = 27)
    Output
      <script>Cookies.set("name_of_cookie", "contents of the cookie", {"expires":27});</script>

# Bad attributes throw errors.

    expiration must be a length-1 double or NULL.

---

    secure_only must be a length-1 logical or NULL.

---

    http_only must be a length-1 logical or NULL.

---

    domain must be a length-1 character or NULL.

---

    path must be a length-1 character or NULL.

# set_cookie_response works as expected.

    Code
      set_cookie_response(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie",
        expiration = NULL)
    Output
      $status
      [1] 200
      
      $content_type
      [1] "text/html; charset=UTF-8"
      
      $content
      [1] ""
      
      $headers
      $headers[[1]]
      Set-cookie: name_of_cookie=contents%20of%20the%20cookie
      
      $headers$`X-UA-Compatible`
      [1] "IE=edge,chrome=1"
      
      
      attr(,"class")
      [1] "httpResponse"

---

    Code
      set_cookie_response(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie",
        http_only = TRUE, expiration = NULL)
    Output
      $status
      [1] 200
      
      $content_type
      [1] "text/html; charset=UTF-8"
      
      $content
      [1] ""
      
      $headers
      $headers[[1]]
      Set-cookie: name_of_cookie=contents%20of%20the%20cookie; HttpOnly
      
      $headers$`X-UA-Compatible`
      [1] "IE=edge,chrome=1"
      
      
      attr(,"class")
      [1] "httpResponse"

---

    Code
      set_cookie_response(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie",
        http_only = TRUE, expiration = NULL, redirect = "/")
    Output
      $status
      [1] 307
      
      $content_type
      [1] "text/html; charset=UTF-8"
      
      $content
      [1] ""
      
      $headers
      $headers[[1]]
      Set-cookie: name_of_cookie=contents%20of%20the%20cookie; HttpOnly
      
      $headers[[2]]
      [1] "Location: /"
      
      $headers$`X-UA-Compatible`
      [1] "IE=edge,chrome=1"
      
      
      attr(,"class")
      [1] "httpResponse"

---

    Code
      set_cookie_response(cookie_name = "name_of_cookie", cookie_value = "contents of the cookie",
        http_only = TRUE, expiration = NULL, redirect = "/", status = 200L)
    Warning <rlang_warning>
      Unexpected status code.
      x Status code 200 provided, expected 300 to 399.
    Output
      $status
      [1] 200
      
      $content_type
      [1] "text/html; charset=UTF-8"
      
      $content
      [1] ""
      
      $headers
      $headers[[1]]
      Set-cookie: name_of_cookie=contents%20of%20the%20cookie; HttpOnly
      
      $headers[[2]]
      [1] "Location: /"
      
      $headers$`X-UA-Compatible`
      [1] "IE=edge,chrome=1"
      
      
      attr(,"class")
      [1] "httpResponse"

