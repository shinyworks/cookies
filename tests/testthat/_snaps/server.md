# set_cookie works.

    Code
      set_cookie(name = "testname", contents = "test contents", session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[90]}} 

---

    Code
      set_cookie(name = "testname", contents = "test contents", expiration = 22,
        session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[22]}} 

---

    Code
      set_cookie(name = "testname", contents = "test contents", expiration = 22,
        secure_only = TRUE, domain = "this", path = "/docs/", same_site = "None",
        session = session)
    Output
      {"name":["testname"],"value":["test contents"],"attributes":{"expires":[22],"secureOnly":[true],"domain":["this"],"path":["/docs/"],"sameSite":["None"]}} 

# remove_cookie works

    Code
      remove_cookie("testname", session = session)
    Output
      {"name":["testname"]} 

