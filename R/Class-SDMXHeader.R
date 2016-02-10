#' @name SDMXHeader
#' @docType class
#' @aliases SDMXHeader-class
#'
#' @title Class "SDMXHeader"
#' @description A basic class to handle the header of a SDMX-ML document
#' 
#' @slot ID Object of class "character" giving the ID of the SDMX-ML document
#' @slot Test Object of class "logical" indicating if the SDMX-ML document is 
#'       disseminated for test purpose
#' @slot Truncated Object of class "logical" indicating if the SDMX-ML document 
#'       is truncated
#' @slot Name Object of class "character" giving the name of SDMX-ML document 
#' @slot Sender Object of class "list" giving the id of the sender and eventually
#'       its in name, possibly in multi-languages
#' @slot Receiver Object of class "list" giving the id of the receiver and 
#'       eventually its in name, possibly in multi-languages
#' @slot Prepared Object of class "POSIXlt" giving the preparation date of the 
#'       SDMX-ML document
#' @slot Extracted Object of class "POSIXlt" giving the extraction date of the 
#'       SDMX-ML document
#' @slot ReportingBegin Object of class "POSIXlt" giving the reporting begin date 
#'       for the data retrieved in the SDMX-ML document
#' @slot ReportingEnd Object of class "POSIXlt" giving the reporting end date for 
#'       the data retrieved in the SDMX-ML document
#' @slot Source Object of class "character" giving the source of the SDMX-ML document
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document
#' 
#' @note
#' Some SDMXHeader properties are not yet supported and thus not available as 
#' "slots". These are "KeyFamilyRef", "KeyFamilyAgency", "DataSetAgency", 
#' "DataSetID", "DataSetAction".
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}

setClass("SDMXHeader",
		representation(
			ID 	= "character", Test = "logical", Truncated = "logical", Name = "character",
			Sender = "list", Receiver = "list",
			Prepared = "POSIXlt", Extracted = "POSIXlt",
			ReportingBegin = "POSIXlt", ReportingEnd = "POSIXlt",
			#KeyFamilyRef = "character", # xs:NMTOKEN?
			#KeyFamilyAgency = "character", # xs:NMTOKEN?
			#DataSetAgency = "character", # xs:NMTOKEN?
			#DataSetID = "character",
			#DataSetAction = "character", #TODO see ActionType
			Source = "character"
		),
		prototype = list(
			ID = "Id", Test = FALSE, Truncated = FALSE, Name = "name",
			Sender = list(id = "SenderID", en = "sender"), Receiver = list(id = "ReceiverID", en="receiver"),
			Prepared = Sys.time(), Extracted = Sys.time(),
			ReportingBegin = Sys.time(), ReportingEnd = Sys.time(),
			#KeyFamilyRef = "character", # xs:NMTOKEN
			#KeyFamilyAgency = "character", # xs:NMTOKEN
			#DataSetAgency = "character", # xs:NMTOKEN
			#DataSetID = "datasetID",
			#DataSetAction = "character", #TODO see ActionType
			Source = "source"
			),
		validity = function(object){
			
			# ID validation
			if(is.null(object@ID)){
        			message("Missing 'ID' in header")
        			return(FALSE)
			}
			if(attr(regexpr("[a-zA-Z0-9@-_@\\$]", object@ID),"match.length") == -1){
  			message("Invalid 'ID' in header")
  			return(FALSE)
			}
        
			#Test/Truncated
			if(!is.logical(object@Test)){
				message("Invalid 'Test' value in header")
			        return(FALSE)
			}
			if(!is.logical(object@Truncated)){
				message("Invalid 'Truncated' value in header")
        			return(FALSE)
			}
        
			#Dates/Time validation
			if(is.na(object@Prepared)){
				message("Invalid 'Prepared' value in header")
        			return(FALSE)
			}
			
			#Sender/Receiver validation
			#Note: deactivated for CONVENIENCE for users (Sender/Receiver mandatory according to SDMX speces)
			#but WorldBank do not constrain users to specify them at download time
			##if(is.na(object@Sender$id) || nchar(object@Sender$id,"w") == 0){
			##	message("Missing 'Sender' id in header") 
        		##	return(FALSE)
			##}
      			##if(nchar(object@Receiver$id,"w") == 0) return(FALSE)
			
			return(TRUE);
		}
)
