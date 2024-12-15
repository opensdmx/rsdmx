#' @name SDMXComponents
#' @rdname SDMXComponents
#' @aliases SDMXComponents,SDMXComponents-method
#' 
#' @usage
#' SDMXComponents(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXComponents"
#' 
#' @seealso \link{readSDMX}
#'
SDMXComponents <- function(xmlObj, namespaces){
  new("SDMXComponents",
      Dimensions = dimensions.SDMXComponents(xmlObj, namespaces),
      TimeDimension = timedimension.SDMXComponents(xmlObj, namespaces),
      PrimaryMeasure = primarymeasure.SDMXComponents(xmlObj, namespaces),
      Attributes = attributes.SDMXComponents(xmlObj, namespaces)
  )
}

#get list of SDMXDimension
#=========================
dimensions.SDMXComponents <- function(xmlObj, namespaces){
  
  dimensions <- NULL
  
  strNs <- findNamespace(namespaces, "structure")
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"


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
    dimensions <- lapply(dimensionsXML, SDMXDimension, namespaces)
  }
  return(dimensions)
}

#get SDMXTimeDimension
#=====================
timedimension.SDMXComponents <- function(xmlObj, namespaces){
  
  timedimension <- NULL
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
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
    timedimension <- SDMXTimeDimension(timeDimensionXML, namespaces)
  }
  return(timedimension)
}

#get SDMXPrimaryMeasure
#======================
primarymeasure.SDMXComponents <- function(xmlObj, namespaces){
  
  primarymeasure <- NULL
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
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
    primarymeasure <- SDMXPrimaryMeasure(measureXML, namespaces)
  }
  return(primarymeasure)
}

#get list of SDMXAttribute
#=========================
attributes.SDMXComponents <- function(xmlObj, namespaces){
  
  attributes <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"

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
    attributes <- lapply(attributesXML, SDMXDimension, namespaces)
  }
  return(attributes)
}

#methods
#'@export
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
  if(nrow(dimensions.df)>0){
    dimensions.df <- cbind(component = "Dimension", dimensions.df,
                          stringsAsFactors = FALSE)
  }
  
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
  if(nrow(attributes.df)>0){
    attributes.df <- cbind(component = "Attribute", attributes.df,
                         stringsAsFactors = FALSE)
  }
  
  #output
  df<- do.call("rbind.fill", list(dimensions.df, timeDimension.df,
                                  primaryMeasure.df, attributes.df))
  return(encodeSDMXOutput(df))
}

setAs("SDMXComponents", "data.frame",
      function(from) as.data.frame.SDMXComponents(from))