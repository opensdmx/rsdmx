# E.Blondel - 2015/10/19
#=======================

#SDMX DataFlow class
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