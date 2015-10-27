#' @name SDMXRequestBuilder
#' @rdname SDMXRequestBuilder
#' @aliases SDMXRequestBuilder,SDMXRequestBuilder-method
#' 
#' @usage
#' SDMXRequestBuilder(regUrl, repoUrl, handler, compliant)
#' 
#' @param regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @param handler an object of class "function" that will be in charge of build a web request.
#' @param compliant an object of class "logical" indicating if the request builder is somehow compliant with a service specification
#' 
#' @details
#' The \code{handler} function must have the following structure in term of arguments 
#' (baseUrl, agencyId, resource, resourceId, version, flowRef, key, start, end, compliant)
#' and output (a string representing the web request to build).
#' 
#' The rsdmx package will as much as possible try to handler generic handlers, 
#' e.g. an handler for SDMX REST web-services. For the latter example, a specific 
#' builder is provided and made part of the specific and still experimental 
#' \link{SDMXRESTRequestBuilder}.
#' 
#' @examples
#'  #an handler
#'  myHandler <- function(baseUrl, agencyId, resource, resourceId, version,
#'                        flowRef, key, start, end, compliant){
#'    req <- paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/")
#'    return(req)
#'  }
#'  
#'  #how to create a SDMXRequestBuilder
#'  requestBuilder <- SDMXRequestBuilder(
#'    regUrl = "http://www.myorg.org/registry",
#'    repoUrl = "http://www.myorg.org/repository",
#'    handler = myHandler, compliant = FALSE)
#'
SDMXRequestBuilder <- function(regUrl, repoUrl, handler, compliant){
  new("SDMXRequestBuilder",
      regUrl = regUrl, repoUrl = repoUrl,
      handler = handler, compliant = compliant)
}
