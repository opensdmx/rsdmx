#' @name SDMXConceptScheme
#' @docType class
#' @aliases SDMXConceptScheme-class
#' 
#' @title Class "SDMXConceptScheme"
#' @description A basic class to handle a SDMX Concept scheme
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
#' @slot Name Object of class "list" giving the concept scheme name (by language) - required
#' @slot Description Object of class "list" giving the concept scheme description (by language)
#' @slot Concept Object of class "list" giving the list of "SDMXConcept" objects (see \link{SDMXConcept})
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition) 
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXConceptScheme",
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
           Name = "list", #at least one
           Description = "list", #optional
           Concept = "list" #optional
         ),
         prototype = list(
           #attributes
           id = "CONCEPTSCHEME_ID",
           agencyID = "AGENCY_ID",
           version = "1.0",
           uri = as.character(NA),
           urn = as.character(NA),
           isExternalReference = FALSE,
           isFinal = FALSE,
           validFrom = as.character(NA),
           validTo = as.character(NA),
           
           #elements
           Name = list(
             en = "concept name",
             fr = "nom du concept"
           ),
           Description = list(
             en = "concept description",
             fr = "description du concept"
           ),
           Concept = list()
         ),
         validity = function(object){  
           
           #validation rules
           if(.rsdmx.options$validate){
            if(is.na(object@id)) return(FALSE)
            if(length(object@Name) == 0) return(FALSE)
           }
           
           return(TRUE);
         }
)