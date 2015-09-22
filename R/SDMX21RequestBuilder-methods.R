# E.Blondel - 2015/09/22
#========================

#constructor
SDMX21RequestBuilder <- function(baseUrl, suffix){
  
  serviceRequestHandler <- function(operation, key, filter = NULL, start = NULL, end = NULL){    
    
    if(is.null(operation))
      stop("Missing SDMX service operation")
    
    reqFilter <- ifelse(is.null(filter), "all", filter)
    reqSuffix <- ifelse(is.null(suffix), "", suffix)
    req <- paste(baseUrl, operation, key, reqFilter, paste0(suffix,"?"), sep="/")
    if(!is.null(start) && !is.null(end)){
      req <- paste0(req, "startPeriod=", start, "&endPeriod=", end) 
    }
    return(req)
  }
  
  new("SDMX21RequestBuilder", baseUrl = baseUrl, suffix = suffix, handler = serviceRequestHandler)
}



