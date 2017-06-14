#' @name SDMXAgency
#' @docType class 
#' @aliases SDMXAgency-class
#' 
#' @title Class "SDMXAgency"
#' @description A basic class to handle a SDMX Concept
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXAgency",
         contains = "SDMXOrganisation",
         representation(),
         prototype = list(),
         validity = function(object){
           return(TRUE);
         }
)