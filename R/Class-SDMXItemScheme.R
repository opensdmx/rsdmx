#' @name SDMXItemScheme
#' @docType class
#' @aliases SDMXItemScheme-class
#' 
#' @title Class "SDMXItemScheme"
#' @description A basic abstract class to handle a SDMXItemScheme
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract "scheme" classes
#' should implement it. Added for the sake of complying with the SDMX information
#' structure model
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXItemScheme",
         representation(),
         prototype = list(),
         validity = function(object){  
           return(TRUE);
         }
)