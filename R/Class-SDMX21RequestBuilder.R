# E.Blondel - 2015/09/22
#=======================

#SDMX 2.1 Request builder class
setClass("SDMX21RequestBuilder",
         contains = "SDMXRequestBuilder",
         representation(),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
