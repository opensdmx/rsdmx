#' @name SDMXConcept
#' @docType class 
#' @aliases SDMXConcept-class
#' 
#' @title Class "SDMXConcept"
#' @description A basic class to handle a SDMX Concept
#' 
#' @slot id Object of class "character" giving the ID of the concept (required)
#' @slot agencyID Object of class "character" giving the AgencyID
#' @slot version Object of class "character" giving the concept version
#' @slot uri Object of class "character" giving the concept uri
#' @slot urn Object of class "character" giving the concept urn
#' @slot isExternalReference Object of class "logical" indicating if the concept is an external reference
#' @slot coreRepresentation Object of class "character" giving the core representation
#' @slot coreRepresentationAgency Object of class "character" giving the core representation agency
#' @slot parent Object of class "character" giving the concept parent
#' @slot parentAgency Object of class "character" giving the parentAgency
#' @slot Name Object of class "list" giving the concept name (by language) - required
#' @slot Description Object of class "list" giving the concept description (by language)
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXConcept",
         representation(
           #attributes
           id = "character", #required
           agencyID = "character", #optional
           version = "character", #optional
           uri = "character", #optional
           urn = "character", #optional
           isExternalReference = "logical", #optional
           coreRepresentation = "character", #optional
           coreRepresentationAgency = "character", #optional
           parent = "character", #optional
           parentAgency = "character", #optional
           
           #elements
           Name = "list", #at least one
           Description = "list" #optional
         ),
         prototype = list(
           #attributes
           id = "CONCEPT_ID",
           agencyID = "AGENCY_ID",
           version = "1.0",
           uri = as.character(NA),
           urn = as.character(NA),
           isExternalReference = FALSE,
           coreRepresentation = as.character(NA),
           coreRepresentationAgency = as.character(NA),
           parent = as.character(NA),
           parentAgency = as.character(NA),
           
           #elements
           Name = list(
             en = "concept name",
             fr = "nom du concept"
           ),
           Description = list(
             en = "concept description",
             fr = "description du concept"
           )
         ),
         validity = function(object){  
           #validation rules
           if(is.na(object@id)) return(FALSE)
           if(length(object@Name) == 0) return(FALSE)
           return(TRUE);
         }
)