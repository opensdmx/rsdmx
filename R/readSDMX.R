#' @title readSDMX
#'
#' @description
#' \code{readSDMX} is the main function to use to read SDMX data
#'
#' @author Emmanuel Blondel \email{emmanuel.blondel1@@gmail.com}
#' @usage readSDMX(file, isURL)  
#' @param file path to SDMX-ML document that needs to be parsed
#' @param isURL a value of class "logical" either the path is an url, and data 
#' has to be downloaded from a SDMX web-repository. Default value is TRUE.
#' @examples 
#' #example 1: FAO data
#' url1 <- "http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008"
#' sdmx1 <- readSDMX(url1)
#' stats1 <- as.data.frame(sdmx1)
#' head(stats1)
#' 
#' #example 2: OECD data
#' #url2 <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MIG/TOT../OECD?startTime=2000&endTime=2011"
#' #sdmx2 <- readSDMX(url2)
#' #stats2 <- as.data.frame(sdmx2)
#' #head(stats2)
#' 
#' #example 3: Eurostat data (local file)
#' tmp <- system.file("data","SDMXGenericDataExample.xml", package="rsdmx")
#' stats3 <- readSDMX(tmp, isURL = F)
#' head(stats3) 

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
		content <- getURL(file)
		xmlObj <- xmlTreeParse(content, useInternalNodes = TRUE)
	}
	
	#encapsulate in S4 object
	type <- SDMXType(xmlObj)@type
	obj <- NULL;
	if(type %in% c("SDMXGenericData", "SDMXMessageGroup", "SDMXCompactData")){
		obj <- SDMXDataSet(xmlObj);
  }else{
		stop("Unsupported SDMX Type")
	}
	
	return(obj);
}

