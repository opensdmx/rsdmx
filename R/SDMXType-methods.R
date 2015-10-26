#' @name SDMXType
#' @rdname SDMXType
#' @aliases SDMXType,SDMXType-method
#' 
#' @usage
#' SDMXType(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXType"
#' 
#' @note
#' At now, the following types have been implemented and successfully tested:
#'  - \code{StructureType},
#'  - \code{GenericDataType},
#'  - \code{CompactDataType},
#'  - \code{StructureSpecificDataType},
#'  - \code{UtilityDataType},
#'  - \code{MessageGroupType}
#' 
#' @seealso \link{readSDMX}
#'
SDMXType <- function(xmlObj){
	new("SDMXType", type = type.SDMXType(xmlObj));
}

type.SDMXType <- function(xmlObj){
  type <- xmlName(xmlRoot(xmlObj))
  if(attr(regexpr(":", type, ignore.case = T),"match.length") > 0){
    type <-strsplit(xmlName(xmlRoot(xmlObj), full=T), ":")[[1]][2]
  }  
	res <- paste(type, "Type", sep="");
	return(res)
}
