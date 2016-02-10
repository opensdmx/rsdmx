#' @name SDMXDataStructureDefinition
#' @docType class
#' @aliases SDMXDataStructureDefinition-class
#' 
#' @title Class "SDMXDataStructureDefinition"
#' @description A basic class to handle a SDMX DataStructureDefinition (DSD)
#' 
#' @slot concepts Object of class "SDMXConcepts" giving the list of concepts or 
#'       conceptSchemes (see \link{SDMXConcepts})
#' @slot codelists Object of class "SDMXCodelists" giving the list of codelists 
#'       (see \link{SDMXCodelists})
#' @slot datastructures Object of class "SDMXDataStructures" giving the list of 
#'       datastructures /key families (see \link{SDMXDataStructures})
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDataStructureDefinition",
         contains = "SDMX",
         representation(
           concepts = "SDMXConcepts",
           codelists = "SDMXCodelists",
           datastructures = "SDMXDataStructures"
         ),
         prototype = list(
           concepts = new("SDMXConcepts"),
           codelists = new("SDMXCodelists"),
           datastructures = new("SDMXDataStructures")
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

setClassUnion("SDMXDataStructureDefinition_OR_NULL",
              c("SDMXDataStructureDefinition","NULL"))