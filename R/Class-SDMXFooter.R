# rsdmx - RSDMXFooter class
#
# Author: Emmanuel Blondel
#==========================

#SDMXFooter class
setClass("SDMXFooter",
         representation(
           messages = "list"
         ),
         prototype = list(
           messages = list()
         ),
         validity = function(object){
           return(TRUE);
         }
)