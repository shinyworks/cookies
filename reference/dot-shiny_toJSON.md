# Prep data for javascript

This is an unexported function in shiny, and has been directly
copy/pasted (other than the name and documentation). This function
formats things in the way shiny's JS functions expect.

## Usage

``` r
.shiny_toJSON(
  x,
  ...,
  dataframe = "columns",
  null = "null",
  na = "null",
  auto_unbox = TRUE,
  digits = getOption("shiny.json.digits", 16),
  use_signif = TRUE,
  force = TRUE,
  POSIXt = "ISO8601",
  UTC = TRUE,
  rownames = FALSE,
  keep_vec_names = TRUE,
  strict_atomic = TRUE
)
```

## Arguments

- x:

  the object to be encoded

- ...:

  Arguments passed on to
  [`jsonlite::toJSON`](https://jeroen.r-universe.dev/jsonlite/reference/fromJSON.html)

  `matrix`

  :   how to encode matrices and higher dimensional arrays: must be one
      of 'rowmajor' or 'columnmajor'.

  `Date`

  :   how to encode Date objects: must be one of 'ISO8601' or 'epoch'

  `factor`

  :   how to encode factor objects: must be one of 'string' or 'integer'

  `complex`

  :   how to encode complex numbers: must be one of 'string' or 'list'

  `raw`

  :   how to encode raw objects: must be one of 'base64', 'hex' or
      'mongo'

  `pretty`

  :   adds indentation whitespace to JSON output. Can be TRUE/FALSE or a
      number specifying the number of spaces to indent (default is 2).
      Use a negative number for tabs instead of spaces.

- dataframe:

  how to encode data.frame objects: must be one of 'rows', 'columns' or
  'values'

- null:

  how to encode NULL values within a list: must be one of 'null' or
  'list'

- na:

  how to print NA values: must be one of 'null' or 'string'. Defaults
  are class specific

- auto_unbox:

  automatically
  [`unbox()`](https://jeroen.r-universe.dev/jsonlite/reference/unbox.html)
  all atomic vectors of length 1. It is usually safer to avoid this and
  instead use the
  [`unbox()`](https://jeroen.r-universe.dev/jsonlite/reference/unbox.html)
  function to unbox individual elements. An exception is that objects of
  class `AsIs` (i.e. wrapped in
  [`I()`](https://rdrr.io/r/base/AsIs.html)) are not automatically
  unboxed. This is a way to mark single values as length-1 arrays.

- digits:

  max number of decimal digits to print for numeric values. Use
  [`I()`](https://rdrr.io/r/base/AsIs.html) to specify significant
  digits. Use `NA` for max precision.

- use_signif:

  Passed on to a print method.

- force:

  unclass/skip objects of classes with no defined JSON mapping

- POSIXt:

  how to encode POSIXt (datetime) objects: must be one of 'string',
  'ISO8601', 'epoch' or 'mongo'

- UTC:

  Passed on to a print method.

- rownames:

  Passed on to a print method.

- keep_vec_names:

  Passed on to a print method.

- strict_atomic:

  Used to deal with atomic vectors and/or unboxing.

## Value

Jsonified text.
