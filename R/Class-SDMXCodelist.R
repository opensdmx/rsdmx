# E.Blondel - 2014/08/20
#=======================

#SDMX Codelist class
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
           if(is.na(object@id)) return(FALSE)
           if(length(object@Name) == 0) return(FALSE)
           return(TRUE);
         }
)