.onLoad <- function (libname, pkgname) {
  assign(".rsdmx.options", new.env(), envir= asNamespace(pkgname))
  setSDMXServiceProviders()
}