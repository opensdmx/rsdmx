# E.Blondel - 2013/06/10
#=======================

#SDMX CompactData class
setClass("SDMXCompactData",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

