# E.Blondel - 2013/06/10
#=======================

#SDMX abstract class
setClass("SDMXDataSetHeader",
		representation(
				"SDMXHeader",
				ReportingBegin = "character",
				ReportingEnd = "character"
		),
		prototype = list(ReportingBegin = "time1", ReportingEnd = "time2"),
		validity = function(object){
			
			#eventual validation rules
			return(TRUE);
		}
)
