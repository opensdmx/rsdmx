# E.Blondel - 2015/01/13
#=======================

#SDMX UtilityData class
setClass("SDMXUtilityData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
