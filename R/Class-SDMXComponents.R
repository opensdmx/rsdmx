#' @name SDMXComponents
#' @docType class
#' @aliases SDMXComponents-class
#' @title Class "SDMXComponents"
#' @description A basic class to handle SDMX Components
#' 
#' @slot Dimensions Object of class "list" giving the list of dimensions (see \link{SDMXDimension})
#' @slot TimeDimension Object of class "SDMXTimeDimension"
#' @slot PrimaryMeasure Object of class "SDMXPrimaryMeasure"
#' @slot Attributes Object of class "list" giving the list of attributes (see \link{SDMXAttribute})
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or 
#' DataStructureDefinitions)
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXComponents",
         representation(
           Dimensions = "list",
           TimeDimension = "SDMXTimeDimension_OR_NULL",
           PrimaryMeasure = "SDMXPrimaryMeasure",
           Attributes = "list"
           #crossSectionalMeasures = "list",
           #Groups = "list
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

setClassUnion("SDMXComponents_OR_NULL", c("SDMXComponents","NULL"))
