#' @name SDMXDotStatRequestBuilder
#' @docType class
#' @aliases SDMXDotStatRequestBuilder-class
#' 
#' @title Class "SDMXDotStatRequestBuilder"
#' @description A experimental class to handle a SDMX DotStat (*.Stat) service 
#'              request builder
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot accessKey an object of class "character" indicating the name of request parameter for which
#'       an authentication or subscription user key/token has to be provided to perform requests 
#' @slot compliant an object of class "logical" indicating if the request builder is somehow compliant with a service specification
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXDotStatRequestBuilder",
         contains = "SDMXRequestBuilder",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
