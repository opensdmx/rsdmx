# E.Blondel - 2014/08/20
#=======================

#SDMX Codelists class
setClass("SDMXCodelists",
         contains = "SDMX",
         representation(
          codelists = "list"
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)