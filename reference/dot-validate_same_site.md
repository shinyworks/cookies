# Ensure same_site is valid

Ensure same_site is valid

## Usage

``` r
.validate_same_site(same_site, secure_only)
```

## Arguments

- same_site:

  One of "strict", "lax" (default), or "none", indicating when the
  cookie should be sent. When `same_site = "none"`, `secure_only` must
  be `TRUE`.

- secure_only:

  Logical indicating whether the cookie should only be accessible via
  secure (`https:`) requests (except on localhost).

## Value

One of `NULL`, "Strict", "Lax", or "None".
