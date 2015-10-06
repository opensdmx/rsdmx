# E.Blondel - 2015/09/22
#=======================

#SDMX Request builder class
setClass("SDMXRequestBuilder",
         representation(
           baseUrl = "character",
           handler = "function",
           compliant = "logical"
         ),
         prototype = list(
           baseUrl = "http://www.myorg.org/sdmx",
           handler = function(baseUrl, agencyId){
             paste(baseUrl, agencyId,sep="/")
           },
           compliant = TRUE
         ),
         validity = function(object){
           return(TRUE);
         }
)
