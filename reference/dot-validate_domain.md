# Ensure domain is valid

Ensure domain is valid

## Usage

``` r
.validate_domain(domain)
```

## Arguments

- domain:

  The host to which the cookie will be sent (including subdomains). If
  this is `NULL` (default) the cookie will only be sent to the host of
  the page where this cookie was set (not including subdomains).

## Value

`NULL` or `domain` as a character.
