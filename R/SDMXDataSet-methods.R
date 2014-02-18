# E.Blondel - 2013/06/10
#=======================

SDMXDataSet <- function(xmlObj){
	sdmx <- SDMX(xmlObj);
	new("SDMXDataSet",
		SDMX(xmlObj)
		)		
}

#methods
as.data.frame.SDMXDataSet <- function(x, ...){
	xmlObj <- x@xmlObj;

	#tag prefix management
	msgPrefix <- unlist(strsplit(xmlName(xmlRoot(xmlObj)[[2]], full=T),':'))[1]
	format <- unlist(strsplit(xmlName(xmlChildren(getNodeSet(xmlObj,paste('//',msgPrefix,':DataSet', sep=''))[[1]])[[1]], full = T),':'))[1]
	
	#concepts (attributes)
	keysXML <- getNodeSet(xmlDoc(getNodeSet(xmlObj, paste("//",format,":SeriesKey", sep=""))[[1]]), paste("//", format, ":Value"))
	keys <- unique(sapply(keysXML, function(x) xmlGetAttr(x, "concept")))
	
	#series
	serieNames <- c(keys, "Time", "ObsValue")
	seriesXML <- getNodeSet(xmlObj, paste('//',format,':Series', sep=''))
	seriesNb <- length(seriesXML)
	if(seriesNb == 0) return(NULL);
	
	#function to parse a Serie
	parseSerie <- function(x){
		
		# Single serie XMLInternalNode converted into a XMLInternalDocument
		serieXML <- xmlDoc(x)
		
		#obsTimes
		obsTimesXML <- getNodeSet(serieXML, paste("//",format,":Series/",format,":Obs/",format,":Time",sep=""))
		obsTime <- sapply(obsTimesXML, function(x) {xmlValue(x)})
		
		#obsValues
		obsValuesXML <- getNodeSet(serieXML, paste("//",format,":Series/",format,":Obs/",format,":ObsValue",sep=""))
		obsValue <- sapply(obsValuesXML, function(x) { as.numeric(xmlGetAttr(x, "value")) })
		
		#Key values
		#SeriesKey (concept attributes/values) are duplicated according to the number of Time observations)
		keyValuesXML <- getNodeSet(serieXML, paste("//",format,":SeriesKey/",format,":Value",sep=""))
		keyValues <- sapply(keyValuesXML, function(x) as.character(xmlGetAttr(x, "value")))
		keydf <- structure(keyValues, .Names = keys) 
		keydf <- data.frame(lapply(keydf, as.character), stringsAsFactors=FALSE)
		keydf <- keydf[rep(row.names(keydf), length(obsTime)),]
		
		#single Serie as DataFrame
		if(length(obsTime) > 0){
			serie <- cbind(keydf, obsTime, obsValue)
		}else{
			serie <- NULL
		}
		return(serie)
	}
	
	#converting SDMX series to a DataFrame R object
	dataset <- do.call("rbind", lapply(seriesXML, function(x){ serie <- parseSerie(x) }))
	
	# output
	return(dataset)
}

setAs("SDMXDataSet", "data.frame", function(from) as.data.frame.SDMXDataSet(from));
