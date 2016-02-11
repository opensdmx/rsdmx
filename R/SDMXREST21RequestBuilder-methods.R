#' @name SDMXREST21RequestBuilder
#' @rdname SDMXREST21RequestBuilder
#' @aliases SDMXREST21RequestBuilder,SDMXREST21RequestBuilder-method
#' 
#' @usage
#'  SDMXREST21RequestBuilder(regUrl, repoUrl, compliant, unsupportedResources,
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
#'   #how to create a SDMXREST21RequestBuilder
#'   requestBuilder <- SDMXREST21RequestBuilder(
#'     regUrl = "http://www.myorg/registry",
#'     repoUrl = "http://www.myorg/repository",
#'     compliant = TRUE)
#'
SDMXREST21RequestBuilder <- function(regUrl, repoUrl, compliant,
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
    
    #wrap argument values
    obj <- list(regUrl = regUrl, repoUrl = repoUrl,
                agencyId = agencyId, resource = resource, resourceId = resourceId, version = version,
                flowRef = flowRef, key = key, start = start, end = end)
    
    #REST resource handler
    resourceHandler <- switch(resource,
      
      #'dataflow' resource (path="dataflow/{agencyID}/{resourceID}/{version}")
      #-----------------------------------------------------------------------
      "dataflow" = function(obj){
        if(is.null(obj$resourceId)) obj$resourceId = "all"
        if(is.null(obj$version)) obj$version = "latest"
        req <- sprintf("%s/dataflow/%s/%s/%s",obj$regUrl, obj$agencyId, obj$resourceId, obj$version)        
        return(req)
      },
                              
      #'datastructure' resource (path="datastructure/{agencyID}/{resourceID}/{version})
      #--------------------------------------------------------------------------------
      "datastructure" = function(obj){    
        if(is.null(obj$resourceId)) obj$resourceId = "all"
        if(is.null(obj$version)) obj$version = "latest"       
        req <- sprintf("%s/datastructure/%s/%s/%s",obj$regUrl, obj$agencyId, obj$resourceId, obj$version)
        if(forceAgencyId) req <- paste(req, obj$agencyId, sep = "/")
        req <- paste0(req, "?references=children") #TODO to see later to have arg for this
        return(req)
      },
                              
      #'data' resource (path="data/{flowRef}/{key}/{providerRef})
      #----------------------------------------------------------
      "data" = function(obj){
        if(is.null(obj$flowRef)) stop("Missing flowRef value")
        if(is.null(obj$key)) obj$key = "all"
        req <- sprintf("%s/data/%s/%s",obj$repoUrl, obj$flowRef, obj$key)
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
  
  new("SDMXREST21RequestBuilder",
      regUrl = regUrl,
      repoUrl = repoUrl,
      handler = serviceRequestHandler,
      compliant = compliant)
}



