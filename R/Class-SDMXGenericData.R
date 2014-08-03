# E.Blondel - 2013/06/10
#=======================

#SDMX GenericData class
setClass("SDMXGenericData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

