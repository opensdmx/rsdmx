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
  dataset <- NULL
  
  sdmxVersion <- getVersion(SDMXSchema(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  #namespace
  nsDefs.df <-as.data.frame(
    do.call("rbind",
            lapply(xmlNamespaceDefinitions(xmlObj, simplify = F),
                   function(x){c(x$id, x$uri)})),
    stringAsFactors = FALSE
  )
  colnames(nsDefs.df) <- c("id","uri")
  nsDefs.df$id <- as.character(nsDefs.df$id)
  nsDefs.df$uri <- as.character(nsDefs.df$uri)
  ns <- c(ns = nsDefs.df$uri[grep("generic", nsDefs.df$uri[grep("metadata", nsDefs.df$uri, invert = TRUE)])])
  if(length(ns) == 0){
    #in case no ns found, try to find specific namespace
    ns.df <- nsDefs.df[regexpr("http://www.SDMX.org", nsDefs.df$uri, "match.length") == -1
                       & regexpr("http://www.w3.org", nsDefs.df$uri, "match.length") == -1,]
    ns <- ns.df$uri
    if(length(ns) > 1){
      warning("More than one target dataset namespace found!")
      ns <- ns[1L]
    }
    hasAuthorityNS <- TRUE
    authorityId <- nsDefs.df[nsDefs.df$uri == ns,]$id
  }
	
  
  if(type.SDMXType(xmlObj) %in% c("SDMXGenericData","SDMXMessageGroup")){
    
    #series
    seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = ns)
    seriesNb <- length(seriesXML)
    if(seriesNb == 0) return(NULL);
    
  	#concepts (attributes)
  	keysXML <- getNodeSet(xmlDoc(getNodeSet(xmlObj, "//ns:SeriesKey", namespaces = ns)[[1]]), "//ns:Value", namespaces = ns)
    conceptId <- "concept"
    if(VERSION.21) conceptId <- "id"
  	keys <- unique(sapply(keysXML, function(x) xmlGetAttr(x, conceptId)))
  	serieNames <- c(keys, "Time", "ObsValue")
  	
  	#function to parse a Serie
  	parseSerie <- function(x){
  		
  		# Single serie XMLInternalNode converted into a XMLInternalDocument
  		serieXML <- xmlDoc(x)
  		
  		#obsTimes
      timeElement <- "Time"
      if(VERSION.21) timeElement <- "ObsDimension"
  		obsTimesXML <- getNodeSet(serieXML,
                                paste("//ns:Series/ns:Obs/ns:",timeElement,sep=""),
                                namespaces = ns)
  		obsTime <- sapply(obsTimesXML, function(x) {
        if(!VERSION.21) xmlValue(x) else xmlGetAttr(x,"value")
  	  })
  		
  		#obsValues
  		obsValuesXML <- getNodeSet(serieXML, "//ns:Series/ns:Obs/ns:ObsValue", namespaces = ns)
  		obsValue <- sapply(obsValuesXML, function(x) { as.numeric(xmlGetAttr(x, "value")) })
  		
  		#Key values
  		#SeriesKey (concept attributes/values) are duplicated according to the number of Time observations)
  		keyValuesXML <- getNodeSet(serieXML, "//ns:SeriesKey/ns:Value", namespaces = ns)
  		keyValues <- sapply(keyValuesXML, function(x) as.character(xmlGetAttr(x, "value")))
  		keydf <- structure(keyValues, .Names = keys) 
  		keydf <- data.frame(lapply(keydf, as.character), stringsAsFactors=FALSE)
  		if(length(obsTime) > 0){
        keydf <- keydf[rep(row.names(keydf), length(obsTime)),]
  		  row.names(keydf) <- 1:length(obsTime)
  		}
        
  		#single Serie as DataFrame
  		if(length(obsTime) > 0){
  			serie <- cbind(keydf, obsTime, obsValue)
  		}else{
  		  #manage absence data
  		  serie <- cbind(keydf, obsTime = rep(NA, dim(keydf)[1L]), obsValue = rep(NA, dim(keydf)[1L]))
  		}
  		return(serie)
  	}
  	
  	#converting SDMX series to a DataFrame R object
  	dataset <- do.call("rbind.fill", lapply(seriesXML, function(x){ serie <- parseSerie(x) }))
  	
  
  }else if(type.SDMXType(xmlObj) == "SDMXCompactData"){
    if(hasAuthorityNS){
      
      seriesXML <- getNodeSet(xmlObj, paste("//",authorityId,":Series",sep=""))
      
      #function to parse a Serie
      parseSerie <- function(x){
        
        #obs values
        obsValueXML <- xmlChildren(x)
        obsValue <- as.data.frame(
                      do.call("rbind", lapply(obsValueXML, function(t){ xmlAttrs(t) })),
                      stringAsFactors = FALSE,
                      row.names = 1:length(obsValueXML))
        
        #key values
        keydf <- data.frame(t(as.data.frame(xmlAttrs(x), stringAsFactors = FALSE)), stringAsFactors = FALSE)
        if(nrow(obsValue) > 0){
          keydf <- keydf[rep(row.names(keydf), nrow(obsValue)),]
          row.names(keydf) <- 1:nrow(obsValue)
        }
          
        #single Serie as DataFrame
        if(nrow(obsValue) > 0){  
          serie <- cbind(keydf, obsValue, row.names = 1:nrow(obsValue))
        }else{
          #manage absence data
          serie <- keydf
        }
        return(serie)
      }
      
      #converting SDMX series to a DataFrame R object
      dataset <- do.call("rbind.fill", lapply(seriesXML, function(x){serie <- parseSerie(x) }))
      
    }else{
      #to see how to deal with this case
      stop("Unsupported CompactData parset for generic SDMX namespace")
    }
  }

  if(any(as.character(dataset$obsValue) == "NaN", na.rm = TRUE)){
    dataset[as.character(dataset$obsValue) == "NaN",]$obsValue <- NA
  }
	if(!is.null(dataset)) row.names(dataset) <- 1:nrow(dataset)
  
	# output
	return(dataset)
}

setAs("SDMXDataSet", "data.frame", function(from) as.data.frame.SDMXDataSet(from));
