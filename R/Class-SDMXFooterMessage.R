# rsdmx - RSDMXFooterMessage class
#
# Author: Emmanuel Blondel
#==========================

#SDMXFooterMessage class
setClass("SDMXFooterMessage",
         representation(
           code = "character",
           severity = "character",
           messages = "list"
         ),
         prototype = list(
           code = "413",
           severity = "Information",
           messages = list("msg1", "msg2")
         ),
         validity = function(object){
           
           # deactivated standard compliance (convenience because of data providers' typos)
           #if(!is.na(object@severity)){
           #   severityTypes <- c("Error", "Warning", "Information")
           #   if(!(object@severity %in% severityTypes)) return(FALSE);
           #}
           
           return(TRUE);
         }
)