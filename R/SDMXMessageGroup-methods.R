#' @name SDMXMessageGroup
#' @rdname SDMXMessageGroup
#' @aliases SDMXMessageGroup,SDMXMessageGroup-method
#' 
#' @usage
#' SDMXMessageGroup(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXMessageGroup"
#' 
#' @seealso \link{readSDMX}
#'
SDMXMessageGroup <- function(xmlObj, namespaces){
  new("SDMXMessageGroup",
      SDMXData(xmlObj, namespaces)
  )		
}

#methods
#=======
class.SDMXMessageGroup <- function(xmlObj){
  
  #namespace
  nsDefs.df <- namespaces.SDMX(xmlObj)
  #in case no ns found, try to find specific namespace
  ns.df <- nsDefs.df[
    regexpr("http://www.sdmx.org", nsDefs.df$uri,
            "match.length", ignore.case = TRUE) == -1,]
  ns.df <- as.data.frame(ns.df, stringsAsFactors = FALSE)
  colnames(ns.df) <- "uri"
  ns <- ns.df$uri
  if(length(ns) > 1) ns <- ns[1L]
  authorityNs <- nsDefs.df[nsDefs.df$uri == ns,]
  authorityNs <- as.data.frame(authorityNs, stringsAsFactors = FALSE)
  colnames(authorityNs) <- "uri"
  if(nrow(authorityNs) == 0){
    hasAuthorityNS <- FALSE
  }else{
    hasAuthorityNS <- TRUE
  }
  
  #business logic to inherit wrapped object class
  wrappedClass <- NULL
  seriesKeyXML <- NULL
  if(hasAuthorityNS){
    seriesKeyXML <- getNodeSet(xmlObj, "//ns:SeriesKey", c(ns = authorityNs$uri)) 
  }else{
    if(nrow(nsDefs.df) > 0){
      seriesKeyXML <- getNodeSet(xmlObj, "//ns:SeriesKey",
                                 c(ns = nsDefs.df[regexpr("generic$", nsDefs.df$uri)>0,"uri"]))
    }else{    
      stop("Unsupported XML parser for empty target XML namespace")
    }
  }
  if(!is.null(seriesKeyXML)){
    if(length(seriesKeyXML) > 0){
      wrappedClass <- "SDMXGenericData"
    }else{
      wrappedClass <- "SDMXCompactData"
    }
  }
  return(wrappedClass)
  
}

as.data.frame.SDMXMessageGroup <- function(x, row.names=NULL, optional=FALSE,
                                           labels = FALSE, ...){
  #TODO support for other included message types
  #(at now limited to SDMXGenericData for making it work with OECD)
  xmlObj <- slot(x, "xmlObj")
  sdmx.df <- switch(class.SDMXMessageGroup(xmlObj),
                    "SDMXGenericData" = as.data.frame.SDMXGenericData(x, labels = labels),
                    "SDMXCompactData" = as.data.frame.SDMXCompactData(x, labels = labels),
                    NULL
             )
  return(encodeSDMXOutput(sdmx.df))
}
