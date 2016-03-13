#' @name SDMXServiceProviders
#' @rdname SDMXServiceProviders
#' @aliases SDMXServiceProviders,SDMXServiceProviders-method
#' 
#' @usage
#'SDMXServiceProviders(providers)
#'
#' @param providers an object of class "list" (of \link{SDMXServiceProvider}) 
#'        configured by default and/or at runtime in \pkg{rsdmx}
#' @return an object of class "SDMXServiceProviders"
#'
SDMXServiceProviders <- function(providers) {
  new("SDMXServiceProviders", providers = providers);
}

as.data.frame.SDMXServiceProviders <- function(x, ...){
  out <- as.data.frame(do.call("rbind",
           lapply(slot(x, "providers"),
                  function(provider){
                    
                    builder <- slot(provider, "builder")
                    
                    c(slot(provider,"agencyId"), slot(provider, "name"),
                      slot(provider, "scale"), slot(provider, "country"),
                      class(builder), slot(builder, "compliant"))
                  })),
            stringsAsFactors = FALSE)
  colnames(out) <- c("agencyId", "name", "scale", "country",
                     "builder", "compliant")
  return(encodeSDMXOutput(out))
}

setAs("SDMXGenericData", "data.frame",
      function(from) {as.data.frame.SDMXServiceProviders(from)});