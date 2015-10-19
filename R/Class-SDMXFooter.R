#' @name SDMXFooter
#' @docType class
#' @aliases SDMXFooter-class
#' @title Class "SDMXFooter"
#' @description A basic class to handle the footer of a SDMX-ML document
#' 
#' @slot messages Object of class "SDMXFooterMessage" giving the list of messages
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @note
#' This class is especially useful for SDMX 2.1 compliant documents. Footer 
#' messages are not supported in SDMX 2.0standard format. In this case, the footer 
#' will return an empty message list().
#' 
#' According to the SDMX 2.1 standard, the message severity takes one of the 
#' following values: "Error", "Warning","Information". Given the possible typos 
#' handled by data providers, rsdmx adopts a permissive strategy and does not 
#' validate the object according to such controlled terms.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXFooter",
         representation(
           messages = "list"
         ),
         prototype = list(
           messages = list()
         ),
         validity = function(object){
           return(TRUE);
         }
)