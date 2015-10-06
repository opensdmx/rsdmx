# E.Blondel - 2015/09/22
#=======================

#SDMX Request builder class
setClass("SDMXRequestBuilder",
         representation(
           regUrl = "character",
           repoUrl = "character",
           handler = "function",
           compliant = "logical"
         ),
         prototype = list(
           regUrl = "http://www.myorg.org/sdmx/registry",
           repoUrl = "http://www.myorg.org/sdmx/repository",
           handler = function(regUrl, repUrl, agencyId){
             paste(regUrl, agencyId,sep="/")
           },
           compliant = TRUE
         ),
         validity = function(object){
           return(TRUE);
         }
)
