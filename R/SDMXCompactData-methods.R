#' @name SDMXCompactData
#' @rdname SDMXCompactData
#' @aliases SDMXCompactData,SDMXCompactData-method
#' 
#' @usage
#' SDMXCompactData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXCompactData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXCompactData <- function(xmlObj){
  new("SDMXCompactData",
      SDMXData(xmlObj)
  )		
}

#methods
as.data.frame.SDMXAllCompactData <- function(x, nsExpr, labels = FALSE, ...) {
  xmlObj <- x@xmlObj;
  dataset <- NULL
  
  schema <- slot(x,"schema")
  sdmxVersion <- slot(schema,"version")
  VERSION.21 <- sdmxVersion == "2.1"
  
  #namespace
  hasAuthorityNS <- FALSE
  nsDefs.df <- getNamespaces(x)
  ns <- findNamespace(nsDefs.df, nsExpr)
  
  authorityNs <- nsDefs.df[
    regexpr("http://www.sdmx.org", nsDefs.df$uri,
              "match.length", ignore.case = TRUE) == -1
    & regexpr("http://www.w3.org", nsDefs.df$uri,
                "match.length", ignore.case = TRUE) == -1,]
  
  if(nrow(authorityNs) > 0){
    hasAuthorityNS <- TRUE
    if(nrow(authorityNs) > 1){
      warning("More than one target dataset namespace found!")
      authorityNs <- authorityNs[1L,]
    }
  }
  
  if(hasAuthorityNS){
    seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = c(ns = authorityNs$uri))
    if(length(seriesXML) == 0){
      seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = ns)
    }
  }else{
    if(length(ns) > 0){
      seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = ns)
    }else{
      if(nrow(nsDefs.df) > 0){
        serieNs <- nsDefs.df[1,]
        seriesXML <- getNodeSet(xmlObj, "//nt:Series", c(nt = serieNs$uri)) 
      }else{    
        stop("Unsupported CompactData parser for empty target XML namespace")
      }
    }
  }
  
  if(length(seriesXML) == 0){
    seriesXML <- getNodeSet(xmlObj, "//Series")
  }
  
  seriesNb <- length(seriesXML)
  if(seriesNb == 0) return(NULL);
  
  #function to parse a Serie
  parseSerie <- function(x){
    
    #obs attributes (which may include observations)
    obsValueXML <- xmlChildren(x)
    obsAttrs <- data.frame()
    if(length(obsValueXML) > 0){
      obsAttrs <- do.call("rbind.fill", lapply(obsValueXML, function(t){
          data.frame(as.list(xmlAttrs(t)), stringsAsFactors = FALSE)
      }))
    }
    
    #obs children (in case we have)
    obsValues <- try(xmlToDataFrame(obsValueXML, stringsAsFactors = FALSE), silent=TRUE)
    if(class(obsValues) == "try-error"){
      obsValues <- NULL
    }else{
      obsKeyNames <- names(lapply(obsValueXML, xmlChildren)[["Key"]])
      obsValues[,obsKeyNames] <- obsValues[1,obsKeyNames]
      obsValues <- obsValues[-1,]
      invisible(lapply(obsKeyNames, function(t) obsValues[nchar(obsValues[,t],"w")==0,t] <<- NA))
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
  
  #enrich with labels
  if(labels){
    dsd <- slot(x, "dsd")
    if(!is.null(dsd)) dataset <- addLabels.SDMXData(dataset, dsd)
  }

  #output
  return(dataset)
}


as.data.frame.SDMXCompactData <- function(x, labels = FALSE, ...){
  return(as.data.frame.SDMXAllCompactData(x, "compact", labels));
}

setAs("SDMXCompactData", "data.frame",
      function(from) as.data.frame.SDMXCompactData(from));
