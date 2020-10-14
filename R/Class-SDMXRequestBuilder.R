#' @name SDMXRequestBuilder
#' @docType class
#' @aliases SDMXRequestBuilder-class
#' 
#' @title Class "SDMXRequestBuilder"
#' @description A basic class to handle a SDMX service request builder
#' 
#' @slot regUrl an object of class "character" giving the base Url of the SDMX service registry
#' @slot repoUrl an object of class "character" giving the base Url of the SDMX service repository
#' @slot accessKey an object of class "character" indicating the name of request parameter for which
#'       an authentication or subscription user key/token has to be provided to perform requests 
#' @slot formatter an object of class "list" giving a formatting function (for each resource) that
#'        takes an object of class "SDMXRequestParams" as single argument. Such parameter allows
#'        to customize eventual params (e.g. specific data provider rules)
#' @slot handler an object of class "list" that will be in charge of build a web request.
#' @slot compliant an object of class "logical" indicating if the request builder is somehow compliant with a service specification 
#' @slot unsupportedResources an object of class "character" giving one or more resources not
#'       supported by the Request builder for a given provider
#' @slot headers an object of class "list" that contains any additional headers for the request.

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
           accessKey = "character_OR_NULL",
           formatter = "list",
           handler = "list",
           compliant = "logical",
           unsupportedResources = "list",
           headers = "list"
         ),
         prototype = list(
           regUrl = "http://www.myorg.org/sdmx/registry",
           repoUrl = "http://www.myorg.org/sdmx/repository",
           accessKey = NULL,
           formatter = list(
             dataflow = function(obj){return(obj)},
             datastructure = function(obj){ return(obj)},
             data = function(obj){return(obj)}
           ),
           handler = list(
              "dataflow" = function(obj){return(obj@regUrl)},
              "datastructure" = function(obj){return(obj@regUrl)},
              "data" = function(obj){return(obj@repoUrl)}
           ),
           compliant = TRUE,
           unsupportedResources = list(),
           headers = list()
         ),
         validity = function(object){
           
           #validation rules
           if(.rsdmx.options$validate){
            if(all(names(object@formatter) != names(object@handler))) return(FALSE)
           }
           
           return(TRUE);
         }
)
