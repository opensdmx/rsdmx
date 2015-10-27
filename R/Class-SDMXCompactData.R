#' @name SDMXCompactData
#' @docType class
#' @aliases SDMXCompactData-class
#' 
#' @title Class "SDMXCompactData"
#' @description A basic class to handle a SDMX-ML compact data set
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXCompactData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

