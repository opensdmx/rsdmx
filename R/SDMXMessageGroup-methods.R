# E.Blondel - 2014/08/03
#=======================

SDMXMessageGroup <- function(xmlObj){
  new("SDMXMessageGroup",
      SDMX(xmlObj)
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
  
  #business logic to inherit wrapped object class
  wrappedClass <- NULL
  seriesKeyXML <- NULL
  if(hasAuthorityNS){
    seriesKeyXML <- getNodeSet(xmlObj, "//ns:SeriesKey", c(ns = authorityNs$uri)) 
  }else{
    if(nrow(nsDefs.df) > 0){
      seriesKeyXML <- getNodeSet(xmlObj, "//ns:SeriesKey", c(ns = nsDefs.df[1,"uri"])) 
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

as.data.frame.SDMXMessageGroup <- function(x, ...){
  #TODO support for other included message types
  #(at now limited to SDMXGenericData for making it work with OECD)
  xmlObj <- slot(x, "xmlObj")
  sdmx.df <- switch(class.SDMXMessageGroup(xmlObj),
                    "SDMXGenericData" = as.data.frame.SDMXGenericData(x),
                    "SDMXCompactData" = as.data.frame.SDMXCompactData(x),
                    NULL
             )
  return(sdmx.df)
}

setAs("SDMXMessageGroup", "data.frame",
      function(from) as.data.frame.SDMXMessageGroup(from));
