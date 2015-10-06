# E.Blondel - 2015/10/06
#=======================

#SDMX Service Providers wrapper class
setClass("SDMXServiceProviders",
         representation(
           providers = "list"
         ),
         prototype = list(
           providers = list()
         ),
         validity = function(object){
           return(TRUE);
         }
)
