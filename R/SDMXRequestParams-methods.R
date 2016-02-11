#' @name SDMXRequestParams
#' @rdname SDMXRequestParams
#' @aliases SDMXRequestParams,SDMXRequestParams-method
#' 
#' @usage
#'  SDMXRequestParams(regUrl, repoUrl, agencyId, resource, resourceId, version,
#'                    flowRef, key, start, end, compliant)
#'
#' @param regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @param repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @param agencyId an object of class "character" giving the agencyID
#' @param resource an object of class "character" giving the type of resource to be queried
#' @param resourceId an object of class "character" giving the resource to be queried
#' @param version an object of class "character" giving the resource version
#' @param flowRef an object of class "character" giving the flowRef to be queried
#' @param key an object of class "character" giving the key (SDMX url formatted) to be used for the query
#' @param start an object of class "character" giving the start time
#' @param end an object of class "character" giving the end time
#' @param compliant an object of class "logical" indicating if the web-service is compliant with the SDMX REST web-service specifications
#'             
#' @examples
#'   #how to create a SDMXRequestParams object
#'   requestBuilder <- (
#'    regUrl = "", repoUrl ="", agencyId ="", resource = "data", resourceId = "",
#'    version = "", flowRef = "", key = NULL, start = NULL, end = NULL, compliant = FALSE
#'   )
#'
SDMXRequestParams <- function(regUrl, repoUrl, agencyId, resource, resourceId, version = NULL,
                              flowRef, key = NULL, start = NULL, end = NULL, compliant){
  new("SDMXRequestParams",
      regUrl = regUrl, repoUrl = repoUrl,
       agencyId = agencyId, resource = resource, resourceId = resourceId, version = version,
       flowRef = flowRef, key = key, start = start, end = end)
}
