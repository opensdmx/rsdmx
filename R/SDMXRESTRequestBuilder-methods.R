# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRESTRequestBuilder <- function(baseUrl, suffix){
  
  serviceRequestHandler <- function(baseUrl, agencyId, suffix, operation, key,
                                    filter = NULL, start = NULL, end = NULL){    
    
    if(is.null(operation))
      stop("Missing SDMX service operation")  
    
    #base request
    req <- paste(baseUrl, operation, key, sep = "/")

    #filter (if any)
    if(!is.null(filter)) req <- paste(req, filter, sep="/")
    
    #suffix
    reqSuffix <- "?"
    if(suffix) reqSuffix <- paste0(agencyId, "?")
    req <- paste(req, reqSuffix, sep="/")
    
    #temporal extent (if any)
    if(!is.null(start) && !is.null(end)){
      req <- paste0(req, "startPeriod=", start, "&endPeriod=", end) 
    }
    
    return(req)
  }
  
  new("SDMXRESTRequestBuilder", baseUrl = baseUrl, suffix = suffix, handler = serviceRequestHandler)
}



