# Ensure http_only is valid

Ensure http_only is valid

## Usage

``` r
.validate_http_only(http_only)
```

## Arguments

- http_only:

  Logical indicating whether the cookie should only be sent as part of
  an HTTP request. When this is `FALSE` (default), the cookie is
  accessible to JavaScript via the `Document.cookie` property.

## Value

`NULL` or `TRUE`.
