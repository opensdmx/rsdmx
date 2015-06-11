# E.Blondel - 2015/06/08
#=======================

#SDMX StructureSpecificData class
setClass("SDMXStructureSpecificData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
