# E.Blondel - 2014/08/19
#=======================

#SDMX Concept class
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