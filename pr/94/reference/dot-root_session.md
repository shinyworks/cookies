# Find the main session

This function escapes from a module (or submodule, etc) to find the root
session.

## Usage

``` r
.root_session(session = shiny::getDefaultReactiveDomain())
```

## Arguments

- session:

  A session object. Probably always use the default.

## Value

The first session that isn't a "session_proxy".
