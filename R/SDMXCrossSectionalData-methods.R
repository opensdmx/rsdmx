#' @name SDMXCrossSectionalData
#' @rdname SDMXCrossSectionalData
#' @aliases SDMXCrossSectionalData,SDMXCrossSectionalData-method
#' 
#' @usage
#' SDMXCrossSectionalData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXCrossSectionalData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXCrossSectionalData <- function(xmlObj){
  new("SDMXCrossSectionalData",
      SDMX(xmlObj)
  )    
}

#methods
#=======

as.data.frame.SDMXCrossSectionalData <- function(x, ...){
  
  xmlObj <- x@xmlObj;
  dataset <- NULL
  
  schema <- slot(x,"schema")
  sdmxVersion <- slot(schema,"version")
  
  #namespace
  hasAuthorityNS <- FALSE
  nsDefs.df <- getNamespaces(x)
  ns <- findNamespace(nsDefs.df, "crosssection")
  
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
  
  #parse Groups
  if(hasAuthorityNS){
    groupsXML <- getNodeSet(xmlObj, "//ns:Group", namespaces = c(ns = authorityNs$uri))
    if(length(groupsXML) == 0){
      groupsXML <- getNodeSet(xmlObj, "//ns:Group", namespaces = ns)
    }
  }else{
    if(length(ns) > 0){
      groupsXML <- getNodeSet(xmlObj, "//ns:Group", namespaces = ns)
    }else{
      if(nrow(nsDefs.df) > 0){
        groupNs <- nsDefs.df[1,]
        groupsXML <- getNodeSet(xmlObj, "//nt:Group", c(nt = groupNs$uri)) 
      }else{    
        stop("Unsupported CrossSectionalData parser for empty target XML namespace")
      }
    }
  }
  
  if(length(groupsXML) == 0){
    groupsXML <- getNodeSet(xmlObj, "//Group")
  }
  
  groupsNb <- length(groupsXML)
  if(groupsNb == 0) return(NULL);
  
  #function to parse a Section
  parseSection <- function(x){
   
    sectionAttrs <- xmlAttrs(x)
    sectionAttrs <- as.data.frame(t(sectionAttrs), stringsAsFactors = FALSE)
    
    sectionChildren <- xmlChildren(x)
    secObs <- names(sectionChildren)
    secValues <- do.call("rbind.fill", lapply(sectionChildren, function(x) {
      attrs <- xmlAttrs(x)
      return(as.data.frame(t(attrs), stringsAsFactors = FALSE))
    }))
    
    secContent <- data.frame(sectionAttrs,
                             obs = secObs,
                             secValues,
                             stringsAsFactors = FALSE)
    return(secContent)
  }
  
  #function to parse a Group
  parseGroup <- function(x){   
    
    groupAttrs <- xmlAttrs(x)
    groupAttrs <- as.data.frame(t(groupAttrs), stringsAsFactors = FALSE)
    x <- xmlDoc(x)
    
    if(hasAuthorityNS){
      secXML <- getNodeSet(x, "//ns:Section", namespaces = c(ns = authorityNs$uri))
      if(length(secXML) == 0){
        secXML <- getNodeSet(x, "//ns:Section", namespaces = ns)
      }
    }else{
      if(length(ns) > 0){
        secXML <- getNodeSet(x, "//ns:Section", namespaces = ns)
      }else{
        if(nrow(nsDefs.df) > 0){
          secNs <- nsDefs.df[1,]
          secXML <- getNodeSet(x, "//nt:Section", c(nt = secNs$uri)) 
        }else{    
          stop("Unsupported CrossSectionalData parser for empty target XML namespace")
        }
      }
    }
    
    if(length(secXML) == 0){
      secXML <- getNodeSet(xmlObj, "//Section")
    }
    
    secNb <- length(secXML)
    if(secNb == 0) return(NULL);
    
    
    #converting SDMX section to a DataFrame R object
    sections <- do.call("rbind.fill", lapply(secXML, parseSection))
    
    group <- data.frame(groupAttrs, sections)
    return(group)
  }
  
  #converting SDMX groups to a DataFrame R object
  dataset <- do.call("rbind.fill", lapply(groupsXML, parseGroup))
  
  if(any(as.character(dataset$obsValue) == "NaN", na.rm = TRUE)){
    dataset[as.character(dataset$obsValue) == "NaN",]$obsValue <- NA
  }
  if(!is.null(dataset)) row.names(dataset) <- 1:nrow(dataset)
  
  # output
  return(dataset)
}

setAs("SDMXCrossSectionalData", "data.frame",
      function(from) as.data.frame.SDMXCrossSectionalData(from));
