#' @name SDMXGenericData
#' @rdname SDMXGenericData
#' @aliases SDMXGenericData,SDMXGenericData-method
#' 
#' @usage
#' SDMXGenericData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXGenericData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXGenericData <- function(xmlObj, namespaces){
  new("SDMXGenericData",
      SDMXData(xmlObj, namespaces)
  )		
}

#methods
as.data.frame.SDMXGenericData <- function(x, row.names=NULL, optional=FALSE,
                                          labels = FALSE, ...){
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
  hasSeries <- length(seriesXML) > 0
  #obs
  obsXML <- getNodeSet(xmlObj, "//ns:Obs", namespaces = ns)
  if(length(obsXML) == 0){
    obsXML <- getNodeSet(xmlObj, "//Obs")
  }
  hasObs <- length(obsXML) > 0
  if(!hasSeries & !hasObs) return(NULL);
  
  conceptId <- "concept"
  if(VERSION.21) conceptId <- "id"
  
  #serie keys
  serieKeysNames <- NULL
  if(hasSeries){
    keysXML <- getNodeSet(xmlDoc(getNodeSet(xmlObj,"//ns:SeriesKey", namespaces = ns)[[1]]),
                          "//ns:Value", namespaces = ns)
    if(length(keysXML)>0){
      serieKeysNames <- unique(sapply(keysXML, function(x) xmlGetAttr(x, conceptId)))
    }
  }
    
  #serie attributes
  serieAttrsNames <- NULL
  serieAttrsXML <- getNodeSet(xmlObj, "//ns:Series/ns:Attributes/ns:Value", namespaces = ns)
  if(length(serieAttrsXML) > 0){
    serieAttrsNames <- unique(sapply(serieAttrsXML, function(x){
      xmlGetAttr(x, conceptId)
    }))
  }
  
  #observation keys
  obsKeysNames <- NULL
  obsKeyXML <- getNodeSet(xmlObj,"//ns:ObsKey", namespaces = ns)
  if(length(obsKeyXML)>0){
    obsKeysXML <- getNodeSet(xmlDoc(obsKeyXML[[1]]), "//ns:Value", namespaces = ns)
    if(length(obsKeysXML)>0){
      obsKeysNames <- unique(sapply(obsKeysXML, function(x) xmlGetAttr(x, conceptId)))
    }    
  }
  
  #observation attributes
  obsAttrsNames <- NULL
  obsAttrsXML <- getNodeSet(xmlObj, "//ns:Obs/ns:Attributes/ns:Value", namespaces = ns)
  if(length(obsAttrsXML) > 0){
    obsAttrsNames <- unique(sapply(obsAttrsXML,function(x){
      xmlGetAttr(x, conceptId)
    }))
  }
  
  #output structure
  serieNames <- serieKeysNames
  if(!is.null(serieAttrsNames)) serieNames <- c(serieNames, serieAttrsNames)
  if(!is.null(obsKeysNames)) serieNames <- c(serieNames, obsKeysNames)
  serieNames <- c(serieNames, "obsTime", "obsValue")
  if(!is.null(obsAttrsNames)) serieNames <- c(serieNames, obsAttrsNames)
  
  hasTime <- FALSE
  
  #obs parser function
  parseObs <- function(obs){
    
    obsXML <- xmlDoc(obs)
    
    #time
    timeElement <- "Time"
    if(VERSION.21) timeElement <- "ObsDimension"
    obsTime <- NA
    obsTimeXML <- getNodeSet(obsXML,
                             paste("//ns:",timeElement,sep=""),
                             namespaces=ns)
    if(length(obsTimeXML)>0){
      hasTime <<- TRUE
      obsTimeXML <- obsTimeXML[[1]]
      if(!VERSION.21){
        obsTime <- xmlValue(obsTimeXML)
      } else {
        obsTime <- xmlGetAttr(obsTimeXML,"value")
      }
      obsTime <- as.data.frame(obsTime)
    }
    
    #value
    obsValue <- NA
    obsValuesXML <-  getNodeSet(obsXML, "//ns:ObsValue", namespaces = ns)
    if(length(obsValuesXML) > 0){
      obsValueXML <- obsValuesXML[[1]]
      obsValue <- as.numeric(sub(",",".", xmlGetAttr(obsValueXML, "value"), fixed = TRUE))
    }
    obsValue <- as.data.frame(obsValue)
    
    #Key values
    #ObsKey (concept attributes/values)
    obskeydf <- NULL
    obsKeyValuesXML <- getNodeSet(obsXML, "//ns:ObsKey/ns:Value", namespaces = ns)
    if(length(obsKeyValuesXML)>0){
      obsKeyValues <- sapply(obsKeyValuesXML, function(x){
        value <- xmlGetAttr(x, "value")
        return(ifelse(is.null(value), as.character(NA), value))
      })
      obsKeyNames <- sapply(obsKeyValuesXML, function(x){
        as.character(xmlGetAttr(x, conceptId))
      })
      obskeydf <- structure(obsKeyValues, .Names = obsKeyNames) 
      obskeydf <- as.data.frame(lapply(obskeydf, as.character), stringsAsFactors=FALSE)
    }
    
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
        
        if(any(is.na(obsAttrs.df))) obsAttrs.df[is.na(obsAttrs.df)] <- "NULL"
        if(ifelse(is.na(any(obsAttrs.df == "NULL")),FALSE, any(obsAttrs.df == "NULL"))){
          obsAttrs.df[obsAttrs.df == "NULL"] <- NA
        }
  
      }
    }
    
    #output
    obsR <- obsValue
    if(!is.na(obsTime)) obsR <- cbind(obsTime, obsR)
    if(!is.null(obskeydf)) obsR <- cbind(obskeydf, obsR)
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
    serieKeyValuesXML <- getNodeSet(serieXML,
                               "//ns:SeriesKey/ns:Value",
                               namespaces = ns)
    serieKeyValues <- sapply(serieKeyValuesXML, function(x){
      as.character(xmlGetAttr(x, "value"))
    })
    
    serieKeyNames <- sapply(serieKeyValuesXML, function(x){
      as.character(xmlGetAttr(x, conceptId))
    })
    
    seriekeydf <- structure(serieKeyValues, .Names = serieKeyNames) 
    seriekeydf <- as.data.frame(lapply(seriekeydf, as.character), stringsAsFactors=FALSE)
    if(!is.null(obsdf)){
      seriekeydf <- seriekeydf[rep(base::row.names(seriekeydf), nrow(obsdf)),]
      if(!is(seriekeydf,"data.frame")){
        seriekeydf <- data.frame(seriekeydf) 
      }
      base::row.names(seriekeydf) <- 1:nrow(obsdf)
      colnames(seriekeydf) <- serieKeyNames
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
          attrs.df <- attrs.df[rep(base::row.names(attrs.df), nrow(obsdf)),]  
          if(!is(attrs.df, "data.frame")){
            attrs.df <- as.data.frame(attrs.df, stringsAsFactors = FALSE)
            colnames(attrs.df) <- attrsNames
          }
          base::row.names(attrs.df) <- 1:nrow(obsdf)
        }
      }
    }  
    
    #single Serie as DataFrame
    serie <- seriekeydf
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
  
  #converting SDMX series/obs to a DataFrame R object
  if(hasSeries){
    dataset <- do.call("rbind.fill", lapply(seriesXML, parseSerie))
  }else{
    dataset <- do.call("rbind.fill", lapply(obsXML, parseObs))
  }
  if(!hasTime) serieNames <- serieNames[-which(serieNames=="obsTime")]
  dataset <- dataset[,serieNames]
  dataset$obsValue <- as.numeric(dataset$obsValue)
  
  if(any(as.character(dataset$obsValue) == "NaN", na.rm = TRUE)){
    dataset[as.character(dataset$obsValue) == "NaN",]$obsValue <- NA
  }
  if(!is.null(dataset)) base::row.names(dataset) <- 1:nrow(dataset)
  
  #enrich with labels
  if(labels){
    dsd <- slot(x, "dsd")
    if(!is.null(dsd)) dataset <- addLabels.SDMXData(dataset, dsd)
  }
  
  # output
  return(encodeSDMXOutput(dataset))
}
