# Ensure expiration is valid

Ensure expiration is valid

## Usage

``` r
.validate_expiration(expiration)
```

## Arguments

- expiration:

  Days after which the cookie should expire. To remove an HttpOnly
  cookie, send a negative value for this attribute.

## Value

`NULL` or the expiration as a double.
