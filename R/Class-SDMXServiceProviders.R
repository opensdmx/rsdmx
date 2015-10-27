#' @name SDMXServiceProviders
#' @docType class
#' @aliases SDMXServiceProviders-class
#' 
#' @title Class "SDMXServiceProviders"
#' @description A class to wrap a list of SDMX service providers
#' 
#' @slot providers an object of class "list" (of \link{SDMXServiceProvider}) 
#'       configured by default and/or at runtime in \pkg{rsdmx}
#' 
#' @section Warning:
#' this class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#'          
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'        
setClass("SDMXServiceProviders",
         representation(
           providers = "list"
         ),
         prototype = list(
           providers = list()
         ),
         validity = function(object){
           return(TRUE);
         }
)
