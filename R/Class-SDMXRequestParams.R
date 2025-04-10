#' @name SDMXRequestParams
#' @docType class
#' @aliases SDMXRequestParams-class
#' 
#' @title Class "SDMXRequestParams"
#' @description A class to handle a SDMX service request params
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot accessKey an object of class "character" indicating the name of request parameter for which
#'       an authentication or subscription user key/token has to be provided to perform requests 
#' @slot providerId an object of class "character" giving the provider agency Id
#' @slot agencyId an object of class "character" giving an agency Id
#' @slot resource an object of class "character" giving the type of resource to be queried
#' @slot resourceId an object of class "character" giving the resource to be queried
#' @slot version an object of class "character" giving the resource version
#' @slot flowRef an object of class "character" giving the flowRef to be queried
#' @slot key an object of class "character" giving the key (SDMX url formatted) to be used for the query
#' @slot start an object of class "character" giving the start time
#' @slot end an object of class "character" giving the end time 
#' @slot references an object of class "character" giving the instructions to return (or not) the artefacts referenced by the artefact to be returned
#' @slot compliant an object of class "logical" indicating if the web-service is compliant with the SDMX REST web-service specifications
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXRequestParams",
         representation(
           regUrl = "character",
           repoUrl = "character",
           accessKey = "character_OR_NULL",
           providerId = "character",
           agencyId = "character_OR_NULL",
           resource = "character",
           resourceId = "character_OR_NULL",
           version = "character_OR_NULL",
           flowRef = "character_OR_NULL",
           key = "character_OR_NULL",
           start = "character_OR_numeric_OR_NULL",
           end = "character_OR_numeric_OR_NULL",
           references = "character_OR_NULL",
           compliant = "logical"
           ),
         prototype = list(),
         validity = function(object){
           return(TRUE);
         }
)
