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