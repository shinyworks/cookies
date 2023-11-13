# set_cookie works.

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents", session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[90]}} 

---

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents",
        expiration = 22, session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[22]}} 

---

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents",
        expiration = 22, secure_only = TRUE, domain = "this", path = "/docs/",
        same_site = "None", session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[22],"secureOnly":[true],"domain":["this"],"path":["/docs/"],"sameSite":["None"]}} 

---

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents",
        secure_only = FALSE, same_site = "None", session = session)
    Condition
      Error in `.validate_same_site()`:
      ! When same_site is None, secure_only must be TRUE.

---

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents", same_site = "blargh",
        session = session)
    Condition
      Error in `.validate_same_site()`:
      ! same_site must be one of Strict, Lax, or None.

---

    Code
      set_cookie(cookie_name = "testname", cookie_value = "test contents", same_site = 1:
        3, session = session)
    Condition
      Error in `.validate_scalar()`:
      ! `same_site` must be a length-1 <character> or NULL.

# remove_cookie works.

    Code
      remove_cookie("testname", session = session)
    Output
      {"name":["testname"]} 

