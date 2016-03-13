.onLoad <- function (libname, pkgname) { # nocov start
  assign(".rsdmx.options", new.env(), envir= asNamespace(pkgname))
  
  #SDMX compliance validation
  .rsdmx.options$validate <- FALSE
  
  #embedded providers
  setSDMXServiceProviders()
  
} # nocov end
