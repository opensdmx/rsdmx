# E.Blondel - 2014/08/20
#=======================

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
  
  dimensionsXML <- getNodeSet(xmlDoc(xmlObj),
                              "//str:Components/str:Dimension",
                              namespaces = c(str = as.character(strNs)))

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
  timeDimXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:Components/str:TimeDimension",
                           namespaces = c(str = as.character(strNs)))
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
  measureXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:Components/str:PrimaryMeasure",
                           namespaces = c(str = as.character(strNs)))
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
  
  attributesXML <- getNodeSet(xmlDoc(xmlObj),
                              "//str:Components/str:Attribute",
                              namespaces = c(str = as.character(strNs)))
  
  if(!is.null(attributesXML)){
    attributes <- lapply(attributesXML, function(x){ SDMXDimension(x)})
  }
  return(attributes)
}