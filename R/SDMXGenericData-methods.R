#' @name SDMXGenericData
#' @rdname SDMXGenericData
#' @aliases SDMXGenericData,SDMXGenericData-method
#' 
#' @usage
#' SDMXGenericData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXGenericData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXGenericData <- function(xmlObj){
  new("SDMXGenericData",
      SDMXData(xmlObj)
  )		
}

#methods
as.data.frame.SDMXGenericData <- function(x, labels = FALSE, ...){
  xmlObj <- x@xmlObj;
  dataset <- NULL
  
  schema <- slot(x,"schema")
  sdmxVersion <- slot(schema,"version")
  VERSION.21 <- sdmxVersion == "2.1"
  
  #namespace
  nsDefs.df <- getNamespaces(x)
  ns <- findNamespace(nsDefs.df, "generic")
  
  #series
  seriesXML <- getNodeSet(xmlObj, "//ns:Series", namespaces = ns)
  if(length(seriesXML) == 0){
    seriesXML <- getNodeSet(xmlObj, "//Series")
  }
  seriesNb <- length(seriesXML)
  if(seriesNb == 0) return(NULL);
  
  conceptId <- "concept"
  if(VERSION.21) conceptId <- "id"
  
  #serie keys
  keysXML <- getNodeSet(xmlDoc(getNodeSet(xmlObj,
                                          "//ns:SeriesKey",
                                          namespaces = ns)[[1]]),
                        "//ns:Value",
                        namespaces = ns)
  keysNames <- unique(sapply(keysXML, function(x) xmlGetAttr(x, conceptId)))
  
  #serie attributes
  serieAttrsNames <- NULL
  serieAttrsXML <- getNodeSet(xmlObj,
                              "//ns:Series/ns:Attributes/ns:Value",
                              namespaces = ns)
  if(length(serieAttrsXML) > 0){
    serieAttrsNames <- unique(sapply(serieAttrsXML, function(x){
      xmlGetAttr(x, conceptId)
    }))
  }
  
  #serie observation attributes
  obsAttrsNames <- NULL
  obsAttrsXML <- getNodeSet(xmlObj,
                            "//ns:Obs/ns:Attributes/ns:Value",
                            namespaces = ns)
  if(length(obsAttrsXML) > 0){
    obsAttrsNames <- unique(sapply(obsAttrsXML,function(x){
      xmlGetAttr(x, conceptId)
    }))
  }
  
  #output structure
  serieNames <- keysNames
  if(!is.null(serieAttrsNames)) serieNames <- c(serieNames, serieAttrsNames)
  serieNames <- c(serieNames, "obsTime", "obsValue")
  if(!is.null(obsAttrsNames)) serieNames <- c(serieNames, obsAttrsNames)
  
  #obs parser function
  parseObs <- function(obs){
    
    obsXML <- xmlDoc(obs)
    
    #time
    timeElement <- "Time"
    if(VERSION.21) timeElement <- "ObsDimension"
    obsTimeXML <- getNodeSet(obsXML,
                             paste("//ns:",timeElement,sep=""),
                             namespaces=ns)[[1]]
    obsTime <- NA
    if(!VERSION.21){
      obsTime <- xmlValue(obsTimeXML)
    } else {
      obsTime <- xmlGetAttr(obsTimeXML,"value")
    }
    obsTime <- as.data.frame(obsTime)
    
    #value
    obsValue <- NA
    obsValuesXML <-  getNodeSet(obsXML,
                                "//ns:ObsValue",
                                namespaces = ns)
    if(length(obsValuesXML) > 0){
      obsValueXML <- obsValuesXML[[1]]
      obsValue <- as.numeric(xmlGetAttr(obsValueXML, "value")) 
    }
    obsValue <- as.data.frame(obsValue)
    
    #attributes
    obsAttrs.df <- NULL
    if(!is.null(obsAttrsNames)){
      obsAttrsXML <- getNodeSet(obsXML,
                                "//ns:Attributes/ns:Value",
                                namespaces = ns)
      if(length(obsAttrsXML) > 0){
        obsAttrsValues <- sapply(obsAttrsXML,
                                 function(x){
                                    as.character(xmlGetAttr(x, "value"))
                                })
        obsAttrsNames <- sapply(obsAttrsXML,
                                 function(x){
                                   as.character(xmlGetAttr(x, conceptId))
                                 })
        
        obsAttrs.df <- structure(obsAttrsValues, .Names = obsAttrsNames) 
        obsAttrs.df <- as.data.frame(lapply(obsAttrs.df, as.character), stringsAsFactors=FALSE)
        
        if(any(obsAttrs.df == "NA")){
          obsAttrs.df[obsAttrs.df == "NA"] <- NA
        }
        if(!is.na(obsAttrs.df) && any(obsAttrs.df == "NULL")){
          obsAttrs.df[obsAttrs.df == "NULL"] <- NA
        }
  
      }
    }
    
    #output
    obsR <- cbind(obsTime, obsValue)
    if(!is.null(obsAttrs.df)) obsR <- cbind(obsR, obsAttrs.df)
    return(obsR)
  }
  
  #function to parse a Serie
  parseSerie <- function(x){
    
    # Single serie XMLInternalNode converted into a XMLInternalDocument
    serieXML <- xmlDoc(x)
    
    #parseobs
    obssXML <- getNodeSet(serieXML, "//ns:Series/ns:Obs", namespaces = ns)
    
    #apply obsParser
    obsdf <- NULL
    if(length(obssXML) > 0){
      obsdf <- do.call("rbind.fill",lapply(obssXML, function(x) parseObs(x)))
    }
    
    #Key values
    #SeriesKey (concept attributes/values) are duplicated according to the
    #number of Time observations
    keyValuesXML <- getNodeSet(serieXML,
                               "//ns:SeriesKey/ns:Value",
                               namespaces = ns)
    keyValues <- sapply(keyValuesXML, function(x){
      as.character(xmlGetAttr(x, "value"))
    })
    
    keyNames <- sapply(keyValuesXML, function(x){
      as.character(xmlGetAttr(x, conceptId))
    })
    
    keydf <- structure(keyValues, .Names = keyNames) 
    keydf <- as.data.frame(lapply(keydf, as.character), stringsAsFactors=FALSE)
    if(!is.null(obsdf)){
      keydf <- keydf[rep(row.names(keydf), nrow(obsdf)),]
      if(class(keydf) == "data.frame"){
        row.names(keydf) <- 1:nrow(obsdf)
        colnames(keydf) <- keyNames
      }
    }
    
    #serie attributes
    attrs.df <- NULL
    serieAttrsXML <- getNodeSet(serieXML,
                             "//ns:Series/ns:Attributes/ns:Value",
                             namespaces = ns)
    if(!is.null(serieAttrsXML)){
      if(length(serieAttrsXML) > 0){
        attrsValues <- sapply(serieAttrsXML, function(x){
          as.character(xmlGetAttr(x, "value"))
        })
        
        attrsNames <- sapply(serieAttrsXML, function(x){
          as.character(xmlGetAttr(x, conceptId))
        })
        
        attrs.df <- structure(attrsValues, .Names = attrsNames) 
        attrs.df <- as.data.frame(lapply(attrs.df, as.character),
                                  stringsAsFactors=FALSE)
        if(!is.null(obsdf)){
          attrs.df <- attrs.df[rep(row.names(attrs.df), nrow(obsdf)),]
          if(is(attrs.df, "data.frame")){
            row.names(attrs.df) <- 1:nrow(obsdf)
            colnames(attrs.df) <- attrsNames
          }
        }
      }
    }  
    
    #single Serie as DataFrame
    serie <- keydf
    if(!is.null(attrs.df)) serie <- cbind(serie, attrs.df)
    if(!is.null(obsdf)) serie <- cbind(serie, obsdf)
      
    #convert factor columns
    if("obsTime" %in% colnames(serie)){
      serie[,"obsTime"] <- as.character(serie[,"obsTime"])
    }
    if(!is.null(obsAttrsNames) & !is.null(obsdf)){
      for(i in 1:length(colnames(obsdf))){
        serie[,colnames(obsdf)[i]] <- as.character(serie[,colnames(obsdf)[i]])
      }
    }
    return(serie)
  }
  
  #converting SDMX series to a DataFrame R object
  dataset <- do.call("rbind.fill", lapply(seriesXML, function(x){
    serie <- parseSerie(x)
  }))
  colnames(dataset) <- serieNames
  dataset$obsValue <- as.numeric(dataset$obsValue)
  
  if(any(as.character(dataset$obsValue) == "NaN", na.rm = TRUE)){
    dataset[as.character(dataset$obsValue) == "NaN",]$obsValue <- NA
  }
  if(!is.null(dataset)) row.names(dataset) <- 1:nrow(dataset)
  
  #enrich with labels
  if(labels){
    dsd <- slot(x, "dsd")
    if(!is.null(dsd)) dataset <- addLabels.SDMXData(dataset, dsd)
  }
  
  # output
  return(dataset)
}

setAs("SDMXGenericData", "data.frame",
      function(from) as.data.frame.SDMXGenericData(from));
