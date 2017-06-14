#' @name SDMXOrganisation
#' @docType class 
#' @aliases SDMXOrganisation-class
#' 
#' @title Class "SDMXOrganisation"
#' @description A basic class to handle a SDMX Concept
#' 
#' @slot id Object of class "character" giving the ID of the concept (required)
#' @slot uri Object of class "character" giving the concept uri
#' @slot urn Object of class "character" giving the concept urn
#' @slot Name Object of class "list" giving the organisation name (by language) - required
#' @slot Description Object of class "list" giving the organisation description (by language)
#'
#' @section Warning:
#' This class is not useful in itself, but other classes such as \link{SDMXAgency}
#' will implement it.
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXOrganisation",
         representation(
           #attributes
           id = "character", #required
           uri = "character", #optional
           urn = "character", #optional
           #elements
           Name = "list", #at least one
           Description = "list" #optional
         ),
         prototype = list(
           #attributes
           id = "ORG",
           uri = as.character(NA),
           urn = as.character(NA),
           
           #elements
           Name = list(
             en = "Org name",
             fr = "nom org"
           ),
           Description = list(
             en = "Org description",
             fr = "nom org"
           )
         ),
         validity = function(object){
           return(TRUE);
         }
)