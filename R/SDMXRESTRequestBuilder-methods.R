# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRESTRequestBuilder <- function(baseUrl, compliant){
  
  #function to handle request
  serviceRequestHandler <- function(baseUrl, agencyId, resource, flowRef,
                                    key = NULL, start = NULL, end = NULL,
                                    compliant){    
    
    if(is.null(resource))
      stop("Missing SDMX service resource")  
    
    restResource <- switch(resource,
      "data" = ifelse(compliant, resource, "GetData")
    )
    
    #wrap argument values
    obj <- list(baseUrl = baseUrl, agencyId = agencyId, resource = restResource,
                flowRef = flowRef, key = key, start = start, end = end)
    
    #REST resource handler
    resourceHandler <- switch(resource,
        
      #'data' resource
        "data" = function(obj){
          
          if(is.null(obj$flowRef)){
            stop("Missing flowRef value")
          }
          if(is.null(obj$key)) obj$key = "all"
          
          #base data request
          req <- paste(obj$baseUrl, obj$resource, obj$flowRef, obj$key, sep = "/")
          
          #DataQuery
          #-> temporal extent (if any)
          if(!is.null(obj$start) && !is.null(obj$end)){
            req <- paste0(req, "/?", "startPeriod=", start, "&endPeriod=", end) 
          }
          
        }
                              
    )
    
    #handle rest resource path
    req <- resourceHandler(obj)
    return(req)
  }
  
  new("SDMXRESTRequestBuilder",
      baseUrl = baseUrl,
      handler = serviceRequestHandler,
      compliant = compliant)
}



