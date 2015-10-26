#' @name SDMXSchema
#' @docType class
#' @aliases SDMXSchema-class
#' @title Class "SDMXSchema"
#' @description A basic class to handle the version of the SDMX-ML Schema
#' 
#' @slot version Object of class "character" giving the SDMX-ML schema version 
#' 
#' @section Warning:
#' this class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#'          
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXSchema",
		representation(
			version = "character"
		),
		prototype = list(version = "2.0"),
		validity = function(object){
			VERSION <- object@version;
			valid <- switch(VERSION,
                "1.0" = TRUE,
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
