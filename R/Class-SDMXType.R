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
                      "StructureType" = TRUE,
                      "GenericDataType" = TRUE,
                      "CompactDataType" = TRUE,
                      "MessageGroupType" = TRUE,
					FALSE
			);
			if(valid == FALSE)
				warning(paste("Unknown SDMXType ", type, sep=""));
			
			return(valid);
		}
)