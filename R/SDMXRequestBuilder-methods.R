#' @name SDMXRequestBuilder
#' @rdname SDMXRequestBuilder
#' @aliases SDMXRequestBuilder,SDMXRequestBuilder-method
#' 
#' @usage
#' SDMXRequestBuilder(regUrl, repoUrl, accessKey = NULL,
#'   formatter, handler, compliant, unsupportedResources = list(), 
#'   headers = list())
#' 
#' @param regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @param accessKey an object of class "character" indicating the name of request parameter for which
#'        an authentication or subscription user key/token has to be provided to perform requests 
#' @param formatter an object of class "list" giving a formatting function (for each resource) that
#'        takes an object of class "SDMXRequestParams" as single argument. Such parameter allows
#'        to customize eventual params (e.g. specific data provider rules)
#' @param handler an object of class "list" that will be in charge of build a web request.
#' @param compliant an object of class "logical" indicating if the request builder is somehow compliant with a service specification
#' @param unsupportedResources an object of class "list" giving one or more resources not
#'        supported by the Request builder for a given provider
#' @param headers an object of class "list" that contains any additional headers for the request.
#' 
#' @details
#' The \code{handler} function will list the resource methods. Each method will accept a
#' single object of class \code{\link{SDMXRequestParams}} as argument. This object will
#' give the different request params as slots (baseUrl, agencyId, resource, resourceId,
#' version, flowRef, key, start, end, compliant) to build the output (a string representing 
#' the web request to build).
#' 
#' The rsdmx package will as much as possible try to handler generic handlers. At now,
#' the available embedded builders are:
#' \link{SDMXREST20RequestBuilder} (connector for SDMX 2.0 web-services),
#' \link{SDMXREST21RequestBuilder} (connector for SDMX 2.1 web-services),
#' \link{SDMXDotStatRequestBuilder} (connector for SDMX .Stat web-services implementations)
#' 
#' @examples
#'  #default formatter
#'  myFormatter = list(
#'    dataflow = function(obj){
#'      #format some obj slots here
#'      return(obj)
#'    },
#'    datastructure = function(obj){
#'      #format some obj slots here
#'      return(obj)
#'    },
#'    data = function(obj){
#'      #format some obj slots here
#'      return(obj)
#'    }
#'  )
#' 
#'  #an handler
#'  #where each element of the list is a function taking as argument an object
#'  #of class "SDMXRequestParams"
#'  myHandler <- list(
#'    "dataflow" = function(obj){return(obj@@regUrl)},
#'    "datastructure" = function(obj){return(obj@@regUrl)},
#'    "data" = function(obj){return(obj@@repoUrl)}
#'  )
#'  
#'  #how to create a SDMXRequestBuilder
#'  requestBuilder <- SDMXRequestBuilder(
#'    regUrl = "http://www.myorg.org/registry",
#'    repoUrl = "http://www.myorg.org/repository",
#'    accessKey = NULL,
#'    formatter = myFormatter, handler = myHandler, compliant = FALSE)
#' @export
#' 
SDMXRequestBuilder <- function(regUrl, repoUrl, accessKey = NULL,
                               formatter, handler, compliant,
                               unsupportedResources = list(), headers = list()){
  
  new("SDMXRequestBuilder",
      regUrl = regUrl, repoUrl = repoUrl, accessKey = accessKey,
      formatter = formatter, handler = handler, compliant = compliant,
      unsupportedResources = unsupportedResources, headers = headers)
}
