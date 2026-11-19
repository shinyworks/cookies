# Generate the separate attribute strings

Generate the separate attribute strings

## Usage

``` r
.generate_http_attribute_strings(http_attributes)
```

## Arguments

- http_attributes:

  A list of attributes with the names expected by Set-Cookie.

## Value

A character vector of either the names (for Secure or HttpOnly) or
name=value pairs.
