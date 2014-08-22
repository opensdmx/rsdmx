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
		  schema = new("SDMXSchema"),
		  header = new("SDMXHeader")
    ),
		validity = function(object){
			
			#eventual validation rules
			return(TRUE);
		}
)

