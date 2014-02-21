# E.Blondel - 2013/06/09
#=======================

#SDMX abstract class
setClass("SDMXType",
		representation(
				type = "character"
		),
		prototype = list(type = "SDMXGenericData"),
		validity = function(object){
			type <- getType(object);
			valid <- switch(type,
					"SDMXGenericData" = TRUE,
					"SDMXMessageGroup" = TRUE,
					FALSE
			);
			if(valid == FALSE)
				stop(paste("Unknown SDMXType ", type, sep=""));
			
			return(TRUE);
		}
)