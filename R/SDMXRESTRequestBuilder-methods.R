# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRESTRequestBuilder <- function(regUrl, repoUrl, compliant){
  
  #function to handle request
  serviceRequestHandler <- function(regUrl, repoUrl, agencyId, resource, resourceId, version = NULL,
                                    flowRef, key = NULL, start = NULL, end = NULL,
                                    compliant){    
    
    if(is.null(resource))
      stop("Missing SDMX service resource")  
    
    restResource <- switch(resource,
      "data" = ifelse(compliant, resource, "GetData"),
      "datastructure" = ifelse(compliant, resource, "GetDataStructure")
    )
    
    #wrap argument values
    obj <- list(regUrl = regUrl, repoUrl = repoUrl,
                agencyId = agencyId, resource = restResource, resourceId = resourceId, version = version,
                flowRef = flowRef, key = key, start = start, end = end)
    
    #REST resource handler
    resourceHandler <- switch(resource,
        
      #'data' resource (path="data/{flowRef}/{key}/{providerRef})
      #----------------------------------------------------------
      "data" = function(obj){
        if(is.null(obj$flowRef)){
          stop("Missing flowRef value")
        }
        if(is.null(obj$key)) obj$key = "all"
        
        #base data request
        req <- paste(obj$repoUrl, obj$resource, obj$flowRef, obj$key, sep = "/")
        
        #DataQuery
        #-> temporal extent (if any)
        if(!is.null(obj$start) && !is.null(obj$end)){
          req <- paste0(req, "/?", "startPeriod=", start, "&endPeriod=", end) 
        }
        return(req)
      },
      
      #'datastructure' resource (path="datastructure/{agencyID}/{resourceID}/{version})
      #--------------------------------------------------------------------------------
      "datastructure" = function(obj){
        
        if(is.null(obj$resourceId)) obj$resourceId = "all"
        if(is.null(obj$version)) obj$version = "latest"
        
        #base datastructure request
        if(compliant){
          req <- paste(obj$regUrl, obj$resource, obj$agencyId, obj$resourceId, obj$version, sep = "/")
          req <- paste0(req, "?references=children") #TODO to see later to have arg for this
        }else{
          req <- paste(obj$regUrl, obj$resource, obj$resourceId, sep = "/")
        }
        return(req)
      }
                              
    )
    
    #handle rest resource path
    req <- resourceHandler(obj)
    return(req)
  }
  
  new("SDMXRESTRequestBuilder",
      regUrl = regUrl,
      repoUrl = repoUrl,
      handler = serviceRequestHandler,
      compliant = compliant)
}



