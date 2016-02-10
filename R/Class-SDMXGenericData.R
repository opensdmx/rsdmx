#' @name SDMXGenericData
#' @docType class
#' @aliases SDMXGenericData-class
#' 
#' @title Class "SDMXGenericData"
#' @description A basic class to handle a SDMX-ML Generic data set
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXGenericData",
         contains = "SDMXData",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

