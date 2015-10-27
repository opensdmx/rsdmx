#' @name SDMXDataFlows
#' @docType class
#' @aliases SDMXDataFlows-class
#' 
#' @title Class "SDMXDataFlows"
#' @description A basic class to handle a SDMX DataFlows
#' 
#' @slot dataflows Object of class "list" giving the list of DataFlows (datasets), 
#'       (see \link{SDMXDataFlow}) 
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition) 
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDataFlows",
         contains = "SDMX",
         representation(
           dataflows = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
