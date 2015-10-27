#' @name SDMXDataFlow
#' @docType class
#' @aliases SDMXDataFlow-class
#' 
#' @title Class "SDMXDataFlow"
#' @description A basic class to handle a SDMX DataFlow
#' 
#' @slot id Object of class "character" giving the ID (required)
#' @slot agencyID Object of class "character" giving the AgencyID
#' @slot version Object of class "character" giving the version
#' @slot uri Object of class "character" giving the uri
#' @slot urn Object of class "character" giving the urn
#' @slot isExternalReference Object of class "logical" indicating if the dataflow is an external reference
#' @slot isFinal Object of class "logical" indicating if the dataflow is final
#' @slot validFrom Object of class "character" indicating the start validity period
#' @slot validTo Object of class "character" indicating the end validity period
#' @slot Name Object of class "list" giving the dataflow (by available language) - required
#' @slot Description Object of class "list" giving the dataflow description (by available language)
#' @slot dsdRef Object of class "character" giving the reference datastructure Id
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition) 
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDataFlow",
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
           dsdRef = "character"
         ),
         prototype = list(
           #attributes
           id = "FLOW_ID",
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
             en = "dataflow name",
             fr = "nom du dataflow"
           ),
           Description = list(
             en = "dataflow description",
             fr = "description du dataflow"
           ),
           dsdRef = "someId"
         ),
         validity = function(object){
           #eventual validation rules
           if(is.na(object@id)) return(FALSE)
           if(length(object@Name) == 0) return(FALSE)
           return(TRUE);
         }
)