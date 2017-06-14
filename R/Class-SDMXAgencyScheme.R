#' @name SDMXAgencyScheme
#' @docType class
#' @aliases SDMXAgencyScheme-class
#' 
#' @title Class "SDMXAgencyScheme"
#' @description A basic abstract class to handle a SDMXAgencyScheme
#'  
#' @slot id Object of class "character" giving the ID of the concept scheme (required)
#' @slot agencyID Object of class "character" giving the AgencyID
#' @slot version Object of class "character" giving the version
#' @slot uri Object of class "character" giving the concept uri
#' @slot urn Object of class "character" giving the concept urn
#' @slot isExternalReference Object of class "logical" indicating if the concept scheme is an external reference
#' @slot isFinal Object of class "logical" indicating if the concept scheme is final
#' @slot validFrom Object of class "character" indicating the start validity period
#' @slot validTo Object of class "character" indicating the end validity period
#' @slot Name Object of class "list" giving the agency scheme name (by language) - required
#' @slot Description Object of class "list" giving the agency scheme description (by language)
#' @slot agencies object of class "list" giving the list of \code{SDMXAgency}                    
#'                                                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXAgencyScheme",
         contains = "SDMXOrganisationScheme",
         representation(
           #attributes
           id = "character", #required
           agencyID = "character", #optional
           version = "character", #optional
           uri = "character", #optional
           urn = "character", #optional
           isExternalReference = "logical", #optional
           isFinal = "logical", #optional
           validFrom = "character", #optional
           validTo = "character", #optional
           
           #elements
           Name = "list",
           Description = "list", #optional
           agencies = "list"
         ),
         prototype = list(
           id = "AGENCIES",
           version = "1.0",
           isFinal = FALSE,
           agencies = list()
         ),
         validity = function(object){  
           return(TRUE);
         }
)