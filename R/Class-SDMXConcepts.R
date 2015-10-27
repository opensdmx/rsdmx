#' @name SDMXConcepts
#' @docType class
#' @aliases SDMXConcepts-class
#' 
#' @title Class "SDMXConcepts" 
#' @description A basic class to handle SDMX Concepts
#' 
#' @slot concepts Object of class "list" giving the list of "SDMXConcept". This 
#'       slot is available to ensure backward compatibility with SDMX 1.0 in SDMX 
#'       2.0 or 2.1 documents      
#' @slot conceptSchemes Object of class "list" giving the list of "SDMXConceptScheme", 
#'       which will encapsulate the list of "SDMXConcept" (defined from SDMX 2.0)
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition) 
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXConcepts",
         contains = "SDMX",
         representation(
           concepts = "list", #required for backward compatibility with SDMX 1.0
           conceptSchemes = "list" #SDMX > 1.0
         ),
         prototype = list(
           concepts = list(),
           conceptSchemes = list()
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)