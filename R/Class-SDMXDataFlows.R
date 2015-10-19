# E.Blondel - 2015/10/19
#=======================

#SDMX DataFlows class
setClass("SDMXDataFlows",
         contains = "SDMX",
         representation(
           dataflows = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
