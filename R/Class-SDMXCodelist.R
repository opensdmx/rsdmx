#' @name SDMXCodelist
#' @docType class
#' @aliases SDMXCodelist-class
#' 
#' @title Class "SDMXCodelist"
#' @description A basic class to handle a SDMX Codelist
#' 
#' @slot id Object of class "character" giving the ID of the codelist (required)
#' @slot agencyID Object of class "character" giving the AgencyID
#' @slot version Object of class "character" giving the version
#' @slot uri Object of class "character" giving the codelist uri
#' @slot urn Object of class "character" giving the codelist urn
#' @slot isExternalReference Object of class "logical" indicating if the codelist is an external reference
#' @slot isFinal Object of class "logical" indicating if the codelist is final
#' @slot validFrom Object of class "character" indicating the start validity period
#' @slot validTo Object of class "character" indicating the end validity period
#' @slot Name Object of class "list" giving the codelist (by language) - required
#' @slot Description Object of class "list" giving the codelist description (by language)
#' @slot Code Object of class "list" giving the list of "SDMXCode" objects included in the codelist (see \link{SDMXCode})
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Codelists, or DataStructureDefinition)
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXCodelist",
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
           Code = "list" #optional
         ),
         prototype = list(
           #attributes
           id = "CODELIST_ID",
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
           Code = list()
         ),
         validity = function(object){

           #eventual validation rules
           if(.rsdmx.options$validate){
            if(is.na(object@id)) return(FALSE)
            if(length(object@Name) == 0) return(FALSE)
           }
           
           return(TRUE);
         }
)