# E.Blondel - 2015/09/22
#=======================

#SDMX Service Provider class
setClass("SDMXServiceProvider",
         representation(
           agencyId = "character",
           name = "character",
           scale = "character",
           country = "character",
           builder = "SDMXRequestBuilder"
         ),
         prototype = list(
           agencyId = "MYORG",
           name = "My Organization",
           scale = "international",
           country = as.character(NA),
           footer = new("SDMXRequestBuilder")
         ),
         validity = function(object){
           return(TRUE);
         }
)
