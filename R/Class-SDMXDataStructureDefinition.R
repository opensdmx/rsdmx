# E.Blondel - 2014/08/21
#=======================

#SDMX DataStructureDefinition class
setClass("SDMXDataStructureDefinition",
         contains = "SDMX",
         representation(
           concepts = "SDMXConcepts",
           codelists = "SDMXCodelists",
           datastructures = "SDMXDataStructures"
         ),
         prototype = list(
           concepts = new("SDMXConcepts"),
           codelists = new("SDMXCodelists"),
           datastructures = new("SDMXDataStructures")
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)