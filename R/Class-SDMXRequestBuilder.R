#' @name SDMXRequestBuilder
#' @docType class
#' @aliases SDMXRequestBuilder-class
#' 
#' @title Class "SDMXRequestBuilder"
#' @description A basic class to handle a SDMX service request builder
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot handler an object of class "function" that will be in charge of build a web request.
#' @slot compliant an object of class "logical" indicating if the request builder is somehow compliant with a service specification 
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXRequestBuilder",
         representation(
           regUrl = "character",
           repoUrl = "character",
           handler = "function",
           compliant = "logical"
         ),
         prototype = list(
           regUrl = "http://www.myorg.org/sdmx/registry",
           repoUrl = "http://www.myorg.org/sdmx/repository",
           handler = function(regUrl, repUrl, agencyId){
             paste(regUrl, agencyId,sep="/")
           },
           compliant = TRUE
         ),
         validity = function(object){
           return(TRUE);
         }
)
