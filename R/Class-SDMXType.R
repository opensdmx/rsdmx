#' @name SDMXType
#' @docType class
#' @aliases SDMXType-class
#' @title Class "SDMXType"
#' 
#' @description A basic class to handle the type of a SDMX-ML document
#' 
#' @slot type Object of class "character" giving the type of the SDMX-ML document
#' 
#' @section Warning:
#' this class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#'          
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXType",
		representation(
				type = "character"
		),
		prototype = list(type = "SDMXGenericData"),
		validity = function(object){
      
      #validation rules
		  if(.rsdmx.options$validate){
  			type <- object@type;
  			valid <- switch(type,
                        "StructureType"             = TRUE,
                        "GenericDataType"           = TRUE,
                        "CompactDataType"           = TRUE,
                        "UtilityDataType"           = TRUE,
                        "StructureSpecificDataType" = TRUE,
                        "CrossSectionalDataType"    = TRUE,
                        "MessageGroupType"          = TRUE,
  					            FALSE
  			);
  			if(valid == FALSE)
  				warning(paste0("Unknown SDMXType ", type));
        
        return(valid)
		  }
      
			return(TRUE);
		}
)