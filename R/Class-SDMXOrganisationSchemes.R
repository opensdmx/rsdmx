#' @name SDMXOrganisationSchemes
#' @docType class
#' @aliases SDMXOrganisationSchemes-class
#' 
#' @title Class "SDMXOrganisationSchemes"
#' @description A basic class to handle a SDMX OrganisationSchemes
#' 
#' @slot organisationSchemes Object of class "list" giving the list of \link{SDMXAgencyScheme}
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXOrganisationSchemes",
         contains = "SDMX",
         representation(
           organisationSchemes = "list"
         ),
         prototype = list(
           organisationSchemes = list()
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
