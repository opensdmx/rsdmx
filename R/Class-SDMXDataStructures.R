#' @name SDMXDataStructures
#' @docType class
#' @aliases SDMXDataStructures-class
#' 
#' @title Class "SDMXDataStructures"
#' @description A basic class to handle a SDMX DataStructures (or KeyFamilies)
#' 
#' @slot datastructures Object of class "list" giving the list of DataStructures, 
#'       (see \link{SDMXDataStructure}) 
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDataStructures",
         contains = "SDMX",
         representation(
           datastructures = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
