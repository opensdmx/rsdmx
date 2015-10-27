#' @name SDMXUtilityData
#' @docType class
#' @aliases SDMXUtilityData-class
#' 
#' @title Class "SDMXUtilityData"
#' @description A basic class to handle a SDMX-ML UtilityData data set
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXUtilityData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
