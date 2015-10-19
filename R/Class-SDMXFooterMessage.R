#' @name SDMXFooterMessage
#' @docType class
#' @aliases SDMXFooterMessage-class
#' @title Class "SDMXFooterMessage"
#' @description A basic class to handle a footer message of a SDMX-ML document
#' 
#' @slot code Object of class "character" giving the status code
#' @slot severity Object of class "character" giving the severity of the message
#' @slot messages Object of class "list" giving the list of messages
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document
#' 
#' @note
#' This class is especially useful for SDMX 2.1 compliant documents. Footer 
#' messages are not supported in SDMX 2.0 standard format.
#' 
#' According to the SDMX 2.1 standard, the message severity takes one of the 
#' following values: "Error", "Warning",Information". Given the possible typos 
#' handled by data providers, rsdmx adopts a permissive strategy and does not 
#' validate the object according to such controlled terms.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXFooterMessage",
         representation(
           code = "character",
           severity = "character",
           messages = "list"
         ),
         prototype = list(
           code = "413",
           severity = "Information",
           messages = list("msg1", "msg2")
         ),
         validity = function(object){
           
           # deactivated standard compliance (convenience because of data providers' typos)
           #if(!is.na(object@severity)){
           #   severityTypes <- c("Error", "Warning", "Information")
           #   if(!(object@severity %in% severityTypes)) return(FALSE);
           #}
           
           return(TRUE);
         }
)