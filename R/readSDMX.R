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
		tmpf<- tempfile(pattern = "RSDMX")
		download.file(file, destfile=tmpf)
		xmlObj <- xmlTreeParse(tmpf, useInternalNodes = TRUE)
	}
	
	#encapsulate in S4 object
	type <- SDMXType(xmlObj)@type
	obj <- NULL;
	if(type == "SDMXGenericData" ||
	   type == "SDMXMessageGroup"){
		obj <- SDMXDataSet(xmlObj);
	}else{
		obj <- SDMX(xmlObj);
	}
	
	return(obj);
}

