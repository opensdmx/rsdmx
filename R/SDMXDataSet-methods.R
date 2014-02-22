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

	nsDefs <- as.vector(xmlNamespaceDefinitions(xmlObj, simplify = T))
	ns <- c(ns = nsDefs[grep("generic", nsDefs[grep("metadata", nsDefs,invert = TRUE)])])
	
	#concepts (attributes)
	keysXML <- getNodeSet(xmlDoc(getNodeSet(xmlObj, "//ns:SeriesKey", namespaces = ns)[[1]]), "//ns:Value", namespaces = ns)
	keys <- unique(sapply(keysXML, function(x) xmlGetAttr(x, "concept")))
	
	#series
	serieNames <- c(keys, "Time", "ObsValue")
	seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = ns)
	seriesNb <- length(seriesXML)
	if(seriesNb == 0) return(NULL);
	
	#function to parse a Serie
	parseSerie <- function(x){
		
		# Single serie XMLInternalNode converted into a XMLInternalDocument
		serieXML <- xmlDoc(x)
		
		#obsTimes
		obsTimesXML <- getNodeSet(serieXML, "//ns:Series/ns:Obs/ns:Time", namespaces = ns)
		obsTime <- sapply(obsTimesXML, function(x) {xmlValue(x)})
		
		#obsValues
		obsValuesXML <- getNodeSet(serieXML, "//ns:Series/ns:Obs/ns:ObsValue", namespaces = ns)
		obsValue <- sapply(obsValuesXML, function(x) { as.numeric(xmlGetAttr(x, "value")) })
		
		#Key values
		#SeriesKey (concept attributes/values) are duplicated according to the number of Time observations)
		keyValuesXML <- getNodeSet(serieXML, "//ns:SeriesKey/ns:Value", namespaces = ns)
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
	row.names(dataset) <- 1:nrow(dataset)
	
	# output
	return(dataset)
}

setAs("SDMXDataSet", "data.frame", function(from) as.data.frame.SDMXDataSet(from));
