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
  hasAuthorityNS <- FALSE
  if(length(ns) > 0) hasAuthorityNS <- TRUE
  
  if(hasAuthorityNS){
    seriesXML <- unlist(
      lapply(ns,
             function(nsUri){
                serieNs <- nsDefs.df[nsDefs.df$uri == nsUri,]
                out <- NULL
                s <- try(getNodeSet(xmlObj, "//ns:Series", c(ns = serieNs$uri)))
                if(class(s) != "try-error") out <- s
                return(out)
             }))
    
  }else{
    if(nrow(nsDefs.df) > 0){
      serieNs <- nsDefs.df[1,]
      seriesXML <- getNodeSet(xmlObj, "//nt:Series", c(nt = serieNs$uri)) 
    }else{    
      stop("Unsupported CompactData parser for empty target XML namespace")
    }
  }
  
  #function to parse a Serie
  parseSerie <- function(x){
    
    #obs attributes (which may include observations)
    obsValueXML <- xmlChildren(x)
    obsAttrs <- as.data.frame(
      do.call("rbind", lapply(obsValueXML, function(t){
        xmlAttrs(t)
      })),
      stringAsFactors = FALSE,
      row.names = 1:length(obsValueXML),
      stringAsFactors = FALSE
    )
    
    #obs children (in case we have)
    obsValues <- try(xmlToDataFrame(obsValueXML, stringsAsFactors = FALSE), silent=TRUE)
    if(class(obsValues) == "try-error"){
      obsValues <- NULL
    }else{
      obsKeyNames <- names(lapply(obsValueXML, xmlChildren)[["Key"]])
      obsValues[,obsKeyNames] <- obsValues[1,obsKeyNames]
      obsValues <- obsValues[-1,]
      invisible(lapply(obsKeyNames, function(t) obsValues[nchar(obsValues[,t])==0,t] <<- NA))
    }
    
    #key values
    keydf <- as.data.frame(t(as.data.frame(xmlAttrs(x), stringAsFactors = FALSE)), stringAsFactors = FALSE)
    if(nrow(obsAttrs) > 0){
      keydf <- keydf[rep(row.names(keydf), nrow(obsAttrs)),]
      if(class(keydf) == "data.frame") row.names(keydf) <- 1:nrow(obsAttrs)
    }
    
    #single Serie as DataFrame
    if(nrow(obsAttrs) > 0){
      obsContent <- obsAttrs
      if(!is.null(obsValues)){
        obsContent <- cbind(obsAttrs, obsValues)
      }
      serie <- cbind(keydf, obsContent, row.names = 1:nrow(obsAttrs))
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
