#' @name SDMXRESTRequestBuilder
#' @rdname SDMXRESTRequestBuilder
#' @aliases SDMXRESTRequestBuilder,SDMXRESTRequestBuilder-method
#' 
#' @usage
#'  SDMXRESTRequestBuilder(regUrl, repoUrl, compliant, unsupportedResources,
#'                         skipAgencyId, forceAgencyId)
#'
#' @param regUrl an object of class "character" giving the base Url of the SDMX 
#'        service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX 
#'        service repository
#' @param compliant an object of class "logical" indicating if the web-service 
#'        is compliant with the SDMX REST web-service specifications
#' @param unsupportedResources an object of class "list" giving eventual unsupported 
#'        REST resources. Default is an empty list object
#' @param skipAgencyId an object of class "logical" indicating that agencyId 
#'        should be skipped. Used to control lack of strong SDMX REST compliance 
#'        from data providers. For now, it applies only for the "data" resource.
#' @param forceAgencyId an object of class "logical" indicating if the agencyId 
#'        as to be added at the end of the request. Default value is \code{FALSE}. 
#'        For some providers, the \code{all} value for the \code{agencyId} is not 
#'        allowed, in this case, the \code{agencyId} of the data provider has to 
#'        be forced in the web-request 
#'                
#' @examples
#'   #how to create a SDMXRESTRequestBuilder
#'   requestBuilder <- SDMXRESTRequestBuilder(
#'     regUrl = "http://www.myorg/registry",
#'     repoUrl = "http://www.myorg/repository",
#'     compliant = TRUE)
#'
SDMXRESTRequestBuilder <- function(regUrl, repoUrl, compliant,
                                   unsupportedResources = list(),
                                   skipAgencyId = FALSE, forceAgencyId = FALSE){
  
  #function to handle request
  serviceRequestHandler <- function(regUrl, repoUrl, agencyId, resource, resourceId, version = NULL,
                                    flowRef, key = NULL, start = NULL, end = NULL,
                                    compliant){    
    
    if(is.null(resource))
      stop("Missing SDMX service resource")
    
    if(resource %in% unsupportedResources)
      stop("Unsupported SDMX service resource for this provider")
    
    restResource <- switch(resource,
      "dataflow" = ifelse(compliant, resource, "GetKeyFamily"),
      "datastructure" = ifelse(compliant, resource, "GetDataStructure"),
      "data" = ifelse(compliant, resource, "GetData")
    )
    
    #wrap argument values
    obj <- list(regUrl = regUrl, repoUrl = repoUrl,
                agencyId = agencyId, resource = restResource, resourceId = resourceId, version = version,
                flowRef = flowRef, key = key, start = start, end = end)
    
    #REST resource handler
    resourceHandler <- switch(resource,
      
      #'dataflow' resource (path="dataflow/{agencyID}/{resourceID}/{version}")
      #-----------------------------------------------------------------------
      "dataflow" = function(xmlObj){
        if(is.null(obj$resourceId)) obj$resourceId = "all"
        if(is.null(obj$version)) obj$version = "latest"
        
        #base dataflow request
        if(compliant){
          req <- paste(obj$regUrl, obj$resource, obj$agencyId, obj$resourceId, obj$version, sep = "/")        
        }else{
          req <- paste(obj$regUrl, obj$resource, obj$resourceId, sep = "/")
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
          if(forceAgencyId) req <- paste(req, obj$agencyId, sep = "/")
          req <- paste0(req, "?references=children") #TODO to see later to have arg for this
        }else{
          req <- paste(obj$regUrl, obj$resource, obj$resourceId, sep = "/")
          if(forceAgencyId) req <- paste(req, obj$agencyId, sep = "/")
        }
        return(req)
      },
                              
      #'data' resource (path="data/{flowRef}/{key}/{providerRef})
      #----------------------------------------------------------
      "data" = function(obj){
        if(is.null(obj$flowRef)){
          stop("Missing flowRef value")
        }
        if(is.null(obj$key)) obj$key = "all"
        
        #base data request
        req <- paste(obj$repoUrl, obj$resource, obj$flowRef, obj$key, sep = "/")
        if(skipAgencyId){
          req <- paste0(req, "/")
        }else{
          req <- paste(req, ifelse(forceAgencyId, obj$agencyId, "all"), sep = "/")
        }
        
        #DataQuery
        #-> temporal extent (if any)
        addParams = FALSE
        if(!is.null(obj$start)){
          req <- paste0(req, "?")
          addParams = TRUE
          req <- paste0(req, "startPeriod=", start)
        }
        if(!is.null(obj$end)){
          if(!addParams){
            req <- paste0(req, "?")
          }else{
            req <- paste0(req, "&")
          }
          req <- paste0(req, "endPeriod=", end) 
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



