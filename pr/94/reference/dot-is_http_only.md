# Is this cookie HttpOnly?

HttpOnly cookies can't be manipulated via javascript.

## Usage

``` r
.is_http_only(cookie_name, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- cookie_name:

  The cookie to check.

- session:

  Shiny session in which the cookies can be found (the default should
  probably always be used).

## Value

A logical indicating whether `cookie_name` is http-only.
