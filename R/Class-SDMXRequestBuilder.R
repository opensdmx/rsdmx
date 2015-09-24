# E.Blondel - 2015/09/22
#=======================

#SDMX Request builder class
setClass("SDMXRequestBuilder",
         representation(
           baseUrl = "character",
           suffix = "logical",
           handler = "function"
         ),
         prototype = list(
           baseUrl = "http://www.myorg.org/sdmx",
           suffix = TRUE,
           handler = function(baseUrl, agencyId){
             paste(baseUrl, agencyId,sep="/")
           }
         ),
         validity = function(object){
           return(TRUE);
         }
)
