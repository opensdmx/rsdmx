# E.Blondel - 2013/06/10
#=======================

SDMXCompactData <- function(xmlObj){
  new("SDMXCompactData",
      SDMX(xmlObj)
  )		
}

#methods
as.data.frame.SDMXCompactData <- function(x, ...){
  xmlObj <- x@xmlObj;
  dataset <- NULL
  
  schema <- getSDMXSchema(x)
  sdmxVersion <- getVersion(schema)
  VERSION.21 <- sdmxVersion == "2.1"
  
  #namespace
  nsDefs.df <- getNamespaces(x)
  #in case no ns found, try to find specific namespace
  ns.df <- nsDefs.df[
    regexpr("http://www.sdmx.org", nsDefs.df$uri,
            "match.length", ignore.case = TRUE) == -1
    & regexpr("http://www.w3.org", nsDefs.df$uri,
            "match.length", ignore.case = TRUE) == -1,]
  ns <- ns.df$uri
  if(length(ns) > 1){
    warning("More than one target dataset namespace found!")
    ns <- ns[1L]
  }
  authorityNs <- nsDefs.df[nsDefs.df$uri == ns,]
  if(nrow(authorityNs) == 0){
    hasAuthorityNS <- FALSE
  }else{
    hasAuthorityNS <- TRUE
  }
  
  if(hasAuthorityNS){
    seriesXML <- getNodeSet(xmlObj, "//ns:Series", c(ns = authorityNs$uri)) 
  }else{
    if(nrow(nsDefs.df) > 0){
      seriesXML <- getNodeSet(xmlObj, "//ns:Series", c(ns = nsDefs.df[1,"uri"])) 
    }else{    
      stop("Unsupported CompactData parser for empty target XML namespace")
    }
  }
  
  #function to parse a Serie
  parseSerie <- function(x){
    
    #obs values
    obsValueXML <- xmlChildren(x)
    obsValue <- as.data.frame(
      do.call("rbind", lapply(obsValueXML, function(t){
        xmlAttrs(t)
      })),
      stringAsFactors = FALSE,
      row.names = 1:length(obsValueXML),
      stringAsFactors = FALSE)
    
    #key values
    keydf <- as.data.frame(t(as.data.frame(xmlAttrs(x), stringAsFactors = FALSE)), stringAsFactors = FALSE)
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
  dataset <- do.call("rbind.fill",
                     lapply(seriesXML, function(x){serie <- parseSerie(x) }))
  
  if(any(as.character(dataset$obsValue) == "NaN", na.rm = TRUE)){
    dataset[as.character(dataset$obsValue) == "NaN",]$obsValue <- NA
  }
  if(!is.null(dataset)) row.names(dataset) <- 1:nrow(dataset)
  
  # output
  return(dataset)
}

setAs("SDMXCompactData", "data.frame",
      function(from) as.data.frame.SDMXCompactData(from));
