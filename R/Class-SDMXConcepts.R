# E.Blondel - 2014/08/19
#=======================

#SDMX Concepts class
setClass("SDMXConcepts",
         contains = "SDMX",
         representation(
           concepts = "list", #required for backward compatibility with SDMX 1.0
           conceptSchemes = "list" #SDMX > 1.0
         ),
         prototype = list(
           concepts = list(),
           conceptSchemes = list()
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)