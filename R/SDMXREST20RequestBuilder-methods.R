#' @name SDMXREST20RequestBuilder
#' @rdname SDMXREST20RequestBuilder
#' @aliases SDMXREST20RequestBuilder,SDMXREST20RequestBuilder-method
#' 
#' @usage
#'  SDMXREST20RequestBuilder(regUrl, repoUrl, accessKey = NULL, formatter, compliant,
#'    unsupportedResources = list(), skipProviderId = FALSE, forceProviderId = FALSE,
#'    headers = list())
#'
#' @param regUrl an object of class "character" giving the base Url of the SDMX 
#'        service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX 
#'        service repository
#' @param accessKey an object of class "character" indicating the name of request parameter for which
#'        an authentication or subscription user key/token has to be provided to perform requests 
#' @param formatter an object of class "list" giving a formatting function (for each resource) that
#'        takes an object of class "SDMXRequestParams" as single argument. Such parameter allows
#'        to customize eventual params (e.g. specific data provider rules)
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
#' @param headers an object of class "list" that contains any additional headers for the request.
#'                
#' @examples
#'   #how to create a SDMXREST20RequestBuilder
#'   requestBuilder <- SDMXREST20RequestBuilder(
#'     regUrl = "http://www.myorg/registry",
#'     repoUrl = "http://www.myorg/repository", compliant = FALSE)
#' @export
#' 
SDMXREST20RequestBuilder <- function(regUrl, repoUrl, accessKey = NULL, 
                                     formatter = NULL,compliant,
                                     unsupportedResources = list(), 
                                     skipProviderId = FALSE, forceProviderId = FALSE,
                                     headers = list()){
    
  #params formatter
  if(is.null(formatter)) formatter = list()
  #dataflow
  if(is.null(formatter$dataflow)) formatter$dataflow = function(obj){return(obj)}
  #datastructure
  if(is.null(formatter$datastructure)) formatter$datastructure = function(obj){ return(obj)}
  #data
  if(is.null(formatter$data)) formatter$data = function(obj){return(obj)}
  
  #resource handler
  handler <- list(
                            
    #dataflow resource (/Dataflow/resourceId/ALL/ALL)
    #-----------------------------------------------------------------------
    dataflow = function(obj){
      resourceId <- obj@resourceId
      if(is.null(resourceId)) resourceId <- "ALL"
      req <- sprintf("%s/Dataflow/%s/ALL/ALL",obj@regUrl, resourceId)
      
      #require key
      if(!is.null(accessKey)){
        if(!is.null(obj@accessKey)){
          if(length(grep("\\?",req))==0) req <- paste0(req, "?")
          req <- paste(req, sprintf("%s=%s", accessKey, obj@accessKey), sep = "&")
        }else{
          stop("Requests to this service endpoint requires an API key")
        }
      }
      return(req)
    },
    #datastructure resource (/DataStructure/ALL/{resourceId}/ALL?references=children)
    #-----------------------------------------------------------------------
    datastructure = function(obj){
      req <- sprintf("%s/DataStructure/ALL/%s/ALL?references=children",
                     obj@regUrl, obj@resourceId)
      #require key
      if(!is.null(accessKey)){
        if(!is.null(obj@accessKey)){
          if(length(grep("\\?",req))==0) req <- paste0(req, "?")
          req <- paste(req, sprintf("%s=%s", accessKey, obj@accessKey), sep = "&")
        }else{
          stop("Requests to this service endpoint requires an API key")
        }
      }
      return(req)
    },
    #data resource (/Data/flowRef/key/agencyId)
    #----------------------------------------------------------
    data = function(obj){
      if(is.null(obj@agencyId)) obj@agencyId = "all"
      if(is.null(obj@flowRef)) stop("Missing flowRef value")
      if(is.null(obj@key)) obj@key = "ALL"
      
      req <- sprintf("%s/Data/%s/%s/%s",
                     obj@repoUrl, obj@flowRef, obj@key, obj@agencyId)
      
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
      
      #require key
      if(!is.null(accessKey)){
        if(!is.null(obj@accessKey)){
          if(length(grep("\\?",req))==0) req <- paste0(req, "?")
          req <- paste(req, sprintf("%s=%s", accessKey, obj@accessKey), sep = "&")
        }else{
          stop("Requests to this service endpoint requires an API key")
        }
      }
      
      return(req)
    }
  )
  
  new("SDMXREST20RequestBuilder",
      regUrl = regUrl,
      repoUrl = repoUrl,
      accessKey = accessKey,
      formatter = formatter,
      handler = handler,
      compliant = compliant,
      unsupportedResources = unsupportedResources,
      headers = headers)
}


