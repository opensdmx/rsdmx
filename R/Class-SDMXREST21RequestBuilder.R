#' @name SDMXREST21RequestBuilder
#' @docType class
#' @aliases SDMXREST21RequestBuilder-class
#' 
#' @title Class "SDMXREST21RequestBuilder"
#' @description A experimental class to handle a SDMX 2.1 service request builder
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot compliant an object of class "logical" indicating if the web-service is compliant with the SDMX REST web-service specifications
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXREST21RequestBuilder",
         contains = "SDMXRequestBuilder",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
