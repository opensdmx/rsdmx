# E.Blondel - 2015/09/22
#=======================

#SDMX REST Request builder class (still experimental)
setClass("SDMXRESTRequestBuilder",
         contains = "SDMXRequestBuilder",
         representation(
          skipAgencyId = "logical",
          forceAgencyId = "logical"  
         ),
         prototype = list(
          skipAgencyId = FALSE,
          forceAgencyId = FALSE
         ),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
