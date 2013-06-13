# E.Blondel - 2013/06/09
#=======================

#SDMXHeader class
setClass("SDMXHeader",
		representation(
			ID = "character",
			Test = "logical",
			Prepared = "POSIXt",
			Sender = "character"
		),
		prototype = list(ID = "An ID", Test = FALSE, Prepared = Sys.time(), Sender = "A Sender ID"),
		validity = function(object){
			
			#eventual validation rules
			return(TRUE);
		}
)
