# E.Blondel - 2015/09/22
#=======================

#SDMX Request builder class
setClass("SDMXRequestBuilder",
         representation(
           baseUrl = "character",
           suffix = "character",
           handler = "function"
         ),
         prototype = list(
           baseUrl = "http://www.myorg.org/sdmx",
           suffix = "service?",
           handler = function(baseUrl, suffix){
             paste(baseUrl,suffix,sep="/")
           }
         ),
         validity = function(object){
           return(TRUE);
         }
)
