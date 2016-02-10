#' @name SDMXData
#' @rdname SDMXData
#' @docType class
#' @aliases SDMXData-class
#' 
#' @title Class "SDMXData"
#' @description An abstract class from which SDMX Data classes are derived
#'
#' @slot dsdRef Object of class "character" giving the DSD Reference
#' @slot dsd Object of class "SDMXDataStructureDefinition"
#'  
#' @section Warning:
#' This class is not useful in itself, but all SDMX Data classes in this package 
#' derive from it.                  
#'  
#'  @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'                  

setClass("SDMXData",
         contains = "SDMX",
         representation(
            dsdRef = "character_OR_NULL",
            dsd = "SDMXDataStructureDefinition_OR_NULL"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
