#' @name SDMXMessageGroup
#' @docType class
#' @aliases SDMXMessageGroup-class
#' 
#' @title Class "SDMXMessageGroup"
#' @description A basic class to handle a SDMX-ML MessageGroup data set
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXMessageGroup",
         contains = "SDMXData",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

