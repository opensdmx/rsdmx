#' @name SDMXREST20RequestBuilder
#' @rdname SDMXREST20RequestBuilder
#' @aliases SDMXREST20RequestBuilder,SDMXREST20RequestBuilder-method
#' 
#' @usage
#'  SDMXREST20RequestBuilder(regUrl, repoUrl, compliant, unsupportedResources,
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
#'   #how to create a SDMXREST20RequestBuilder
#'   requestBuilder <- SDMXREST20RequestBuilder(
#'     regUrl = "http://www.myorg/registry",
#'     repoUrl = "http://www.myorg/repository", compliant = FALSE)
#'
SDMXREST20RequestBuilder <- function(regUrl, repoUrl, compliant,
                                     unsupportedResources = list(),
                                     skipAgencyId = FALSE, forceAgencyId = FALSE){
    
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
                            
    #'dataflow' resource (path="/Dataflow/{resourceId}/ALL/ALL")
    #-----------------------------------------------------------------------
    dataflow = function(obj){
      resourceId <- obj@resourceId
      if(is.null(resourceId)) resourceId <- "ALL"
      req <- sprintf("%s/Dataflow/%s/ALL/ALL",obj@regUrl, resourceId)
      return(req)
    },
    #'datastructure' resource (path="/DataStructure/ALL/{resourceId}/ALL?references=children")
    #-----------------------------------------------------------------------
    datastructure = function(obj){
      req <- sprintf("%s/DataStructure/ALL/%s/ALL?references=children",
                     obj@regUrl, obj@resourceId)
      return(req)
    },
    #'data' resource (path="/Data/{flowRef}/{key}/{agencyId}")
    #----------------------------------------------------------
    data = function(obj){
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
      
      return(req)
    }
  )
  
  new("SDMXREST20RequestBuilder",
      regUrl = regUrl,
      repoUrl = repoUrl,
      formatter = formatter,
      handler = handler,
      compliant = compliant,
      unsupportedResources = unsupportedResources)
}


