# E.Blondel - 2014/08/20
#=======================

#SDMX Components class
setClass("SDMXComponents",
         representation(
           Dimensions = "list",
           TimeDimension = "SDMXTimeDimension",
           PrimaryMeasure = "SDMXPrimaryMeasure",
           Attributes = "list"
           #crossSectionalMeasures = "list",
           #Groups = "list
         ),
         prototype = list(),
         validity = function(object){
           #eventual validation rules
           return(TRUE);
         }
)
