#' @name SDMXCompactData
#' @rdname SDMXCompactData
#' @aliases SDMXCompactData,SDMXCompactData-method
#' 
#' @usage
#' SDMXCompactData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXCompactData"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXCompactData <- function(xmlObj, namespaces){
  new("SDMXCompactData",
      SDMXData(xmlObj, namespaces)
  )		
}

#methods
getSDMXAllCompactData <- function(x, nsExpr, labels = FALSE, ...) {
  xmlObj <- x@xmlObj;
  dataset <- NULL
  
  schema <- slot(x,"schema")
  sdmxVersion <- slot(schema,"version")
  VERSION.21 <- sdmxVersion == "2.1"
  
  #namespace
  hasAuthorityNS <- FALSE
  nsDefs.df <- getNamespaces(x)
  ns <- findNamespace(nsDefs.df, nsExpr)
  if(length(ns) > 1) ns <- ns[1]
  
  authorityNamespaces <- nsDefs.df[
    attr(regexpr("http://www.sdmx.org", nsDefs.df$uri, ignore.case = TRUE), "match.length") == -1,]
  authorityNamespaces <- as.data.frame(authorityNamespaces, stringsAsFactors = FALSE)
  colnames(authorityNamespaces) <- "uri"
  
  if(nrow(authorityNamespaces) > 0){
    nsIdx <- 1
    hasAuthorityNS <- TRUE
    if(nrow(authorityNamespaces) > 1){
      authorityNs <- authorityNamespaces[nsIdx,]
      authorityNs <- as.data.frame(authorityNs, stringsAsFactors = FALSE)
      colnames(authorityNs) <- "uri"
    }else{
      authorityNs <- authorityNamespaces
    }
  }
  
  if(hasAuthorityNS){
    #try to get series with authority namespaces
    seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = c(ns = authorityNs$uri))
    while(nsIdx <= nrow(authorityNamespaces) && length(seriesXML) == 0){
      nsIdx <- nsIdx + 1
      authorityNs <- authorityNamespaces[nsIdx,]
      authorityNs <- as.data.frame(authorityNs, stringsAsFactors = FALSE)
      colnames(authorityNs) <- "uri"
      seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = c(ns = authorityNs$uri))
    }
    
    if(length(seriesXML) == 0){
      seriesXML <- try(getNodeSet(xmlObj, "//ns:Series", namespaces = ns), silent = TRUE)
      if(is(seriesXML,"try-error")) seriesXML <- list()
    }
  }else{
    if(length(ns) > 0){
      seriesXML <- try(getNodeSet(xmlObj, "//ns:Series", namespaces = ns), silent = TRUE)
      if(is(seriesXML,"try-error")) seriesXML <- list()
    }else{
      if(nrow(nsDefs.df) > 0){
        serieNs <- nsDefs.df[1,]
        serieNs <- as.data.frame(serieNs, stringsAsFactors = FALSE)
        colnames(serieNs) <- "uri"
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
    if(is(obsValues,"try-error")){
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
      if(is(keydf,"data.frame")) row.names(keydf) <- 1:nrow(obsAttrs)
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
  return(encodeSDMXOutput(dataset))
}

#'@export
as.data.frame.SDMXCompactData <- function(x, row.names=NULL, optional=FALSE,
                                          labels = FALSE, ...){
  return(getSDMXAllCompactData(x, nsExpr = "compact", labels = labels));
}
