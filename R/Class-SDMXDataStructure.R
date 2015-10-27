#' @name SDMXDataStructure
#' @docType class
#' @aliases SDMXDataStructure-class
#' 
#' @title Class "SDMXDataStructure"
#' @description A basic class to handle a SDMX DataStructure (or KeyFamily)
#' 
#' @slot id Object of class "character" giving the ID (required)
#' @slot agencyID Object of class "character" giving the AgencyID
#' @slot version Object of class "character" giving the version
#' @slot uri Object of class "character" giving the uri
#' @slot urn Object of class "character" giving the urn
#' @slot isExternalReference Object of class "logical" indicating if the datastructure / keyfamily is an external reference
#' @slot isFinal Object of class "logical" indicating if the datastructure / keyfamily is final
#' @slot validFrom Object of class "character" indicating the start validity period
#' @slot validTo Object of class "character" indicating the end validity period
#' @slot Name Object of class "list" giving the codelist (by language) - required
#' @slot Description Object of class "list" giving the codelist description (by language)
#' @slot Components Object of class "SDMXComponents" (see \link{SDMXComponents})
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDataStructure",
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
           Components = "SDMXComponents_OR_NULL" #optional
         ),
         prototype = list(
           #attributes
           id = "KEYFAMILY_ID",
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
             en = "datastructure/keyfamily name",
             fr = "nom du datastrucure/keyfamily"
           ),
           Description = list(
             en = "datastructure/keyfamily description",
             fr = "description du datastructure/keyfamily"
           ),
           Components = new("SDMXComponents")
         ),
         validity = function(object){
           #eventual validation rules
           if(is.na(object@id)) return(FALSE)
           if(length(object@Name) == 0) return(FALSE)
           return(TRUE);
         }
)