#' @name SDMXRequestParams
#' @docType class
#' @aliases SDMXRequestParams-class
#' 
#' @title Class "SDMXRequestParams"
#' @description A class to handle a SDMX service request params
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot agencyId an object of class "character" giving the agencyID
#' @slot resource an object of class "character" giving the type of resource to be queried
#' @slot resourceId an object of class "character" giving the resource to be queried
#' @slot version an object of class "character" giving the resource version
#' @slot flowRef an object of class "character" giving the flowRef to be queried
#' @slot key an object of class "character" giving the key (SDMX url formatted) to be used for the query
#' @slot start an object of class "character" giving the start time
#' @slot end an object of class "character" giving the end time
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
           agencyId = "character",
           resource = "character",
           resourceId = "character_OR_NULL",
           version = "character_OR_NULL",
           flowRef = "character_OR_NULL",
           key = "character_OR_NULL",
           start = "character_OR_numeric_OR_NULL",
           end = "character_OR_numeric_OR_NULL",
           compliant = "logical"
           ),
         prototype = list(),
         validity = function(object){
           return(TRUE);
         }
)
