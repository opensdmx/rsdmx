# E.Blondel - 2014/08/20
#=======================

#SDMX DataStructures / KeyFamilies class
setClass("SDMXDataStructures",
         contains = "SDMX",
         representation(
           datastructures = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
