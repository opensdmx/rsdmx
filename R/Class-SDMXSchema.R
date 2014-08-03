# E.Blondel - 2013/06/09
#=======================

# SDMXSchema class
setClass("SDMXSchema",
		representation(
			version = "character"
		),
		prototype = list(version = "2.0"),
		validity = function(object){
			VERSION <- getVersion(object);
			valid <- switch(VERSION,
								"2.0" = TRUE,
                "2.1" = TRUE,
								FALSE
							);
			if(valid == FALSE)
				warning(paste("SDMXSchema version ", VERSION," not supported by RSDMX",
                      sep=""));
			return(valid);
		}
)
