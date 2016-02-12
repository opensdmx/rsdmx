#' @name SDMXREST21RequestBuilder
#' @rdname SDMXREST21RequestBuilder
#' @aliases SDMXREST21RequestBuilder,SDMXREST21RequestBuilder-method
#' 
#' @usage
#'  SDMXREST21RequestBuilder(regUrl, repoUrl, compliant, unsupportedResources,
#'                         skipProviderId, forceProviderId)
#'
#' @param regUrl an object of class "character" giving the base Url of the SDMX 
#'        service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX 
#'        service repository
#' @param compliant an object of class "logical" indicating if the web-service 
#'        is compliant with the SDMX REST web-service specifications
#' @param unsupportedResources an object of class "list" giving eventual unsupported 
#'        REST resources. Default is an empty list object
#' @param skipProviderId an object of class "logical" indicating that the provider
#'        agencyIdshould be skipped. Used to control lack of strong SDMX REST compliance 
#'        from data providers. For now, it applies only for the "data" resource.
#' @param forceProviderId an object of class "logical" indicating if the provider
#'        agencyId has to be added at the end of the request. Default value is 
#'        \code{FALSE}. For some providers, the \code{all} value for the provider
#'        agency id is not allowed, in this case, the \code{agencyId} of the data 
#'        provider has to be forced in the web-request 
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
                                     skipProviderId = FALSE, forceProviderId = FALSE){
  
  #params formatter
  formatter = list(
    #dataflow
    dataflow = function(obj){return(obj)},
    #datastructure
    datastructure = function(obj){ return(obj)},
    #data
    data = function(obj){return(obj)}
  )
  
  #resource handler
  handler <- list(
      
    #'dataflow' resource (path="dataflow/{agencyID}/{resourceID}/{version}")
    #-----------------------------------------------------------------------
    dataflow = function(obj){
      if(is.null(obj@agencyId)) obj@agencyId = "all"
      if(is.null(obj@resourceId)) obj@resourceId = "all"
      if(is.null(obj@version)) obj@version = "latest"
      req <- sprintf("%s/dataflow/%s/%s/%s/",obj@regUrl, obj@agencyId, obj@resourceId, obj@version)        
      return(req)
    },
                            
    #'datastructure' resource (path="datastructure/{agencyID}/{resourceID}/{version})
    #--------------------------------------------------------------------------------
    datastructure = function(obj){
      if(is.null(obj@agencyId)) obj@agencyId = "all"
      if(is.null(obj@resourceId)) obj@resourceId = "all"
      if(is.null(obj@version)) obj@version = "latest"
      req <- sprintf("%s/datastructure/%s/%s/%s/",obj@regUrl, obj@agencyId, obj@resourceId, obj@version)
      if(forceProviderId) req <- paste(req, obj@providerId, sep = "/")
      req <- paste0(req, "?references=children") #TODO to see later to have arg for this
      return(req)
    },
                            
    #'data' resource (path="data/{flowRef}/{key}/{providerRef})
    #----------------------------------------------------------
    data = function(obj){
      if(is.null(obj@flowRef)) stop("Missing flowRef value")
      if(is.null(obj@key)) obj@key = "all"
      req <- sprintf("%s/data/%s/%s",obj@repoUrl, obj@flowRef, obj@key)
      if(skipProviderId){
        req <- paste0(req, "/")
      }else{
        req <- paste(req, ifelse(forceProviderId, obj@providerId, "all"), sep = "/")
        req <- paste0(req, "/")
      }
      
      #DataQuery
      #-> temporal extent (if any)
      addParams = FALSE
      if(!is.null(obj@start)){
        req <- paste0(req, "?")
        addParams = TRUE
        req <- paste0(req, "startPeriod=", obj@start)
      }
      if(!is.null(obj@end)){
        if(!addParams){
          req <- paste0(req, "?")
        }else{
          req <- paste0(req, "&")
        }
        req <- paste0(req, "endPeriod=", obj@end) 
      }
      return(req)
    }
  )
  
  new("SDMXREST21RequestBuilder",
      regUrl = regUrl,
      repoUrl = repoUrl,
      formatter = formatter,
      handler = handler,
      compliant = compliant,
      unsupportedResources = unsupportedResources)
}
