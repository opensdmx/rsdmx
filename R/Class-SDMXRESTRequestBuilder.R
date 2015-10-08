# E.Blondel - 2015/09/22
#=======================

#SDMX REST Request builder class (still experimental)
setClass("SDMXRESTRequestBuilder",
         contains = "SDMXRequestBuilder",
         representation(
          forceAgencyId = "logical"  
         ),
         prototype = list(
          forceAgencyId = FALSE
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
