# E.Blondel - 2013/06/10
#=======================

#SDMX MessageGroup class
setClass("SDMXMessageGroup",
         contains = "SDMX",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)

