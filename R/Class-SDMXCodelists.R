#' @name SDMXCodelists
#' @docType class
#' @aliases SDMXCodelists-class
#' 
#' @title Class "SDMXCodelists"
#' @description A basic class to handle SDMX Codelists
#' 
#' @slot codelists Object of class "list" giving the list of "SDMXCodelist"
#' 
#' @section Warning:
#' This class is not useful in itself, but \link{SDMXDataStructureDefinition} objects
#' will encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXCodelists",
         contains = "SDMX",
         representation(
          codelists = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)