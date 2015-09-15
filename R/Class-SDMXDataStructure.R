# E.Blondel - 2014/08/20
#=======================

#SDMX DataStructure / KeyFamily class
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