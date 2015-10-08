# E.Blondel - 2015/10/06
#========================

#constructor
SDMXServiceProviders <- function(providers) {
  new("SDMXServiceProviders", providers = providers);
}

as.data.frame.SDMXServiceProviders <- function(x, ...){
  out <- as.data.frame(do.call("rbind",
           lapply(slot(x, "providers"),
                  function(provider){
                    c(slot(provider,"agencyId"), slot(provider, "name"),
                      slot(provider, "scale"), slot(provider, "country"))
                  })),
            stringsAsFactors = FALSE)
  colnames(out) <- c("agencyId", "name", "scale", "country")
  return(out)
}

setAs("SDMXGenericData", "data.frame",
      function(from) {as.data.frame.SDMXServiceProviders(from)});