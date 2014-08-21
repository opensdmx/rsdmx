# E.Blondel - 2013/06/09
#=======================

#SDMX base abstract class
setClass("SDMX",
		representation(
			xmlObj = "XMLInternalDocument",
			schema = "SDMXSchema",
			header = "SDMXHeader"
		),
		prototype = list(
      xmlObj = NULL,
      schema = NULL,
      header = NULL
    ),
		validity = function(object){
			
			#eventual validation rules
			return(TRUE);
		}
)

