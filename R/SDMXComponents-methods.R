#' @name SDMXComponents
#' @rdname SDMXComponents
#' @aliases SDMXComponents,SDMXComponents-method
#' 
#' @usage
#' SDMXComponents(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXComponents"
#' 
#' @seealso \link{readSDMX}
#'
SDMXComponents <- function(xmlObj){
  new("SDMXComponents",
      Dimensions = dimensions.SDMXComponents(xmlObj),
      TimeDimension = timedimension.SDMXComponents(xmlObj),
      PrimaryMeasure = primarymeasure.SDMXComponents(xmlObj),
      Attributes = attributes.SDMXComponents(xmlObj)
  )
}

#get list of SDMXDimension
#=========================
dimensions.SDMXComponents <- function(xmlObj){
  
  dimensions <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  strNs <- findNamespace(namespaces, "structure")

  dimensionsXML <- NULL
  if(VERSION.21){
    dimensionsXML <- getNodeSet(xmlDoc(xmlObj),
                              "//str:DimensionList/str:Dimension",
                              namespaces = c(str = as.character(strNs)))
  }else{
    dimensionsXML <- getNodeSet(xmlDoc(xmlObj),
                                "//str:Dimension",
                                namespaces = c(str = as.character(strNs))) 
  }
  
  if(!is.null(dimensionsXML)){
    dimensions <- lapply(dimensionsXML, function(x){ SDMXDimension(x)})
  }
  return(dimensions)
}

#get SDMXTimeDimension
#=====================
timedimension.SDMXComponents <- function(xmlObj){
  
  timedimension <- NULL
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  strNs <- findNamespace(namespaces, "structure")
  
  timeDimXML <- NULL
  if(VERSION.21){
    timeDimXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:DimensionList/str:TimeDimension",
                             namespaces = c(str = as.character(strNs)))
  }else{
    timeDimXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:TimeDimension",
                           namespaces = c(str = as.character(strNs)))
  }
  
  if(length(timeDimXML) > 0){
    timeDimensionXML <- timeDimXML[[1]]
    timedimension <- SDMXTimeDimension(timeDimensionXML)
  }
  return(timedimension)
}

#get SDMXPrimaryMeasure
#======================
primarymeasure.SDMXComponents <- function(xmlObj){
  
  primarymeasure <- NULL
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  strNs <- findNamespace(namespaces, "structure")
  
  if(VERSION.21){
    measureXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:MeasureList/str:PrimaryMeasure",
                             namespaces = c(str = as.character(strNs)))
  }else{
    measureXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:PrimaryMeasure",
                           namespaces = c(str = as.character(strNs)))
  }
  
  if(length(measureXML) > 0){
    measureXML <- measureXML[[1]]
    primarymeasure <- SDMXPrimaryMeasure(measureXML)
  }
  return(primarymeasure)
}

#get list of SDMXAttribute
#=========================
attributes.SDMXComponents <- function(xmlObj){
  
  attributes <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  strNs <- findNamespace(namespaces, "structure")
  
  if(VERSION.21){
    attributesXML <- getNodeSet(xmlDoc(xmlObj),
                                "//str:AttributeList/str:Attribute",
                                namespaces = c(str = as.character(strNs)))
  }else{
    attributesXML <- getNodeSet(xmlDoc(xmlObj),
                              "//str:Attribute",
                              namespaces = c(str = as.character(strNs)))
  }
  if(!is.null(attributesXML)){
    attributes <- lapply(attributesXML, function(x){ SDMXDimension(x)})
  }
  return(attributes)
}

#methods
as.data.frame.SDMXComponents <- function(x, ...){
 
  #dimensions
  dimensions <- slot(x, "Dimensions")
  dimensions.df <- as.data.frame(
    do.call("rbind",
      lapply(
        dimensions, 
        function(x){
          sapply(slotNames(x), function(elem){slot(x,elem)})
        }
      )
    ),stringsAsFactors = FALSE)
  dimensions.df <- cbind(component = "Dimension", dimensions.df,
                         stringsAsFactors = FALSE)
  
  #time dimension
  timeDimension <- slot(x, "TimeDimension")
  timeDimension.df <- NULL
  if(!is.null(timeDimension)){
    timeDimension.df <- as.data.frame(
      t(sapply(slotNames(timeDimension), function(elem){slot(timeDimension,elem)})),
      stringsAsFactors = FALSE
    )
    timeDimension.df <- cbind(component = "TimeDimension", timeDimension.df,
                              stringsAsFactors = FALSE)
  }
  
  #primary measure
  primaryMeasure <- slot(x, "PrimaryMeasure")
  primaryMeasure.df <- as.data.frame(
    t(sapply(slotNames(primaryMeasure), function(elem){slot(primaryMeasure,elem)})),
    stringsAsFactors = FALSE
  )
  primaryMeasure.df <- cbind(component = "PrimaryMeasure", primaryMeasure.df,
                            stringsAsFactors = FALSE)
  
  #attributes
  attributes <- slot(x, "Attributes")
  attributes.df <- as.data.frame(
    do.call("rbind",
            lapply(
              attributes, 
              function(x){
                sapply(slotNames(x), function(elem){slot(x,elem)})
              }
            )
    ),stringsAsFactors = FALSE)
  attributes.df <- cbind(component = "Attribute", attributes.df,
                         stringsAsFactors = FALSE)
  
  #output
  df<- do.call("rbind.fill", list(dimensions.df, timeDimension.df,
                                  primaryMeasure.df, attributes.df))
  return(df)
}

setAs("SDMXComponents", "data.frame",
      function(from) as.data.frame.SDMXComponents(from));