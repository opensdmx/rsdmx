#' @name SDMXCrossSectionalData
#' @docType class
#' @aliases SDMXCrossSectionalData-class
#' 
#' @title Class "SDMXCrossSectionalData"
#' @description A basic class to handle a SDMX-ML cross sectional data set
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXCrossSectionalData",
         contains = "SDMXData",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
