# Convert expiration days to the expected date format

Convert expiration days to the expected date format

## Usage

``` r
.http_date(expiration)
```

## Arguments

- expiration:

  Days after which the cookie should expire. To remove an HttpOnly
  cookie, send a negative value for this attribute.

## Value

A string of the date in the required format.
