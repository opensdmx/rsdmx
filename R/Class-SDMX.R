# E.Blondel - 2013/06/09
#=======================

#SDMX base abstract class
setClass("SDMX",
	representation(
		xmlObj = "XMLInternalDocument",
		schema = "SDMXSchema",
		header = "SDMXHeader",
    footer = "SDMXFooter"
	),
	prototype = list(
      		xmlObj = NULL,
      		schema = new("SDMXSchema"),
      		header = new("SDMXHeader"),
          footer = new("SDMXFooter")
      	),
	validity = function(object){
		return(TRUE);
	}
)

