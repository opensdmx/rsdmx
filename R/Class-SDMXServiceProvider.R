# E.Blondel - 2015/09/22
#=======================

#SDMX Service Provider class
setClass("SDMXServiceProvider",
         representation(
           id = "character",
           name = "character",
           builder = "SDMXRequestBuilder"
         ),
         prototype = list(
           id = "MYORG",
           name = "My Organization",
           footer = new("SDMXRequestBuilder")
         ),
         validity = function(object){
           return(TRUE);
         }
)
