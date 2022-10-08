# set_cookie returns the expected tagList.

    Code
      set_cookie(contents = "contents of the cookie", cookie_name = "name_of_cookie",
        expiration = 27)
    Output
      <script>Cookies.set('name_of_cookie', 'contents of the cookie', { expires: 27 });</script>

