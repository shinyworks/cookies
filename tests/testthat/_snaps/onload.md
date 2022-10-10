# set_cookie_on_load returns the expected tagList.

    Code
      set_cookie_on_load(name = "name_of_cookie", contents = "contents of the cookie")
    Output
      <script>Cookies.set("name_of_cookie", "contents of the cookie", {"expires":90});</script>

---

    Code
      set_cookie_on_load(name = "name_of_cookie", contents = "contents of the cookie",
        expiration = 27)
    Output
      <script>Cookies.set("name_of_cookie", "contents of the cookie", {"expires":27});</script>

