# E.Blondel - 2014/08/20
#=======================

#SDMX Code class
setClass("SDMXCode",
         representation(
           #attributes
           id = "character", #required (equivalent to "value" in SDMX 2.0)
           urn = "character", #optional
           parentCode = "character", #optional
           
           #elements
           label = "list" #optional - generic slot that will handle the code label
                          #using the 'Name' (SDMX 2.1) or 'Description' (SDMX 2.0)
         ),
         prototype = list(
           #attributes
           id = "CODE_ID",
           urn = as.character(NA),
           parentCode = as.character(NA),
           
           #elements
           label = list(
             en = "code label",
             fr = "label du code"
           )
         ),
         validity = function(object){
           #eventual validation rules
           if(is.na(object@id)) return(FALSE)
           if(length(object@label) == 0) return(FALSE)
           return(TRUE);
         }
)