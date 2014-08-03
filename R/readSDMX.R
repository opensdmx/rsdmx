# E.Blondel - 2013/06/10
#=======================

# function to read SDMX as character string
# (required in order to encapsulate a S3 old class object in a S4 representation)
readSDMX <- function(file, isURL = TRUE){
	
	#load data
	if(isURL == FALSE){
		if(!file.exists(file))
			stop("File ", file, "not found\n")
		xmlObj <- xmlTreeParse(file, useInternalNodes = TRUE)
	}else{
    rsdmxAgent <- paste("rsdmx/",as.character(packageVersion("rsdmx")),sep="")
		content <- getURL(
      file,
      httpheader = list('User-Agent' = rsdmxAgent)
    )
		xmlObj <- xmlTreeParse(content, useInternalNodes = TRUE)
	}
	
	#encapsulate in S4 object
	type <- SDMXType(xmlObj)@type
	obj <- NULL;
	if(type %in% c("SDMXGenericData", "SDMXMessageGroup", "SDMXCompactData")){
		obj <- SDMXDataSet(xmlObj);
  }else if(type == "SDMXStructure"){
    strTypeObj <- SDMXStructureType(xmlObj)
    strType <- getType(strTypeObj)
    obj <- NULL
    stop("Unsupported SDMX Structure Types")
    
  }else{
		stop("Unsupported SDMX Type")
	}
	
	return(obj);
}

