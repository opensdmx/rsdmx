.onLoad <- function (libname, pkgname) { # nocov start
  assign(".rsdmx.options", new.env(), envir= asNamespace(pkgname))
  setSDMXServiceProviders()
} # nocov end
