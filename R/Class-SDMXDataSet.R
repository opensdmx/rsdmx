# E.Blondel - 2013/06/10
#=======================

#SDMX abstract class
setClass("SDMXDataSet",
		representation("SDMX"),
		prototype = list(),
		validity = function(object){
			
			#eventual validation rules
			return(TRUE);
		}
)

