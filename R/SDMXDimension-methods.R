# E.Blondel - 2014/08/20
#=======================

SDMXDimension <- function(xmlObj){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  #attributes
  #=========
  conceptRef = xmlGetAttr(xmlObj, "conceptRef")
  if(is.null(conceptRef)) conceptRef <- as.character(NA)
  
  conceptVersion = xmlGetAttr(xmlObj, "conceptVersion")
  if(is.null(conceptVersion)) conceptVersion <- as.character(NA)
  
  conceptAgency = xmlGetAttr(xmlObj, "conceptAgency")
  if(is.null(conceptAgency)) conceptAgency <- as.character(NA)
  
  conceptSchemeRef = xmlGetAttr(xmlObj, "conceptSchemeRef")
  if(is.null(conceptSchemeRef)) conceptSchemeRef <- as.character(NA)
  
  conceptSchemeAgency = xmlGetAttr(xmlObj, "conceptSchemeAgency")
  if(is.null(conceptSchemeAgency)) conceptSchemeAgency <- as.character(NA)
  
  codelist = xmlGetAttr(xmlObj, "codelist")
  if(is.null(codelist)) codelist <- as.character(NA)

  codelistVersion = xmlGetAttr(xmlObj, "codelistVersion")
  if(is.null(codelistVersion)) codelistVersion <- as.character(NA)
  
  codelistAgency = xmlGetAttr(xmlObj, "codelistAgency")
  if(is.null(codelistAgency)) codelistAgency <- as.character(NA)
  
  isMeasureDimension = xmlGetAttr(xmlObj, "isMeasureDimension")
  if(is.null(isMeasureDimension)){
    isMeasureDimension <- FALSE
  }else{
    isMeasureDimension <- as.logical(isMeasureDimension)
  }
  
  isFrequencyDimension = xmlGetAttr(xmlObj, "isFrequencyDimension")
  if(is.null(isFrequencyDimension)){
    isFrequencyDimension <- FALSE
  }else{
    isFrequencyDimension <- as.logical(isFrequencyDimension)
  }
  
  isEntityDimension = xmlGetAttr(xmlObj, "isEntityDimension")
  if(is.null(isEntityDimension)){
    isEntityDimension <- FALSE
  }else{
    isEntityDimension <- as.logical(isEntityDimension)
  }
  
  isCountDimension = xmlGetAttr(xmlObj, "isCountDimension")
  if(is.null(isCountDimension)){
    isCountDimension <- FALSE
  }else{
    isCountDimension <- as.logical(isCountDimension)
  }
  
  isNonObservationTimeDimension = xmlGetAttr(xmlObj,
                                             "isNonObservationTimeDimension")
  if(is.null(isNonObservationTimeDimension)){
    isNonObservationTimeDimension <- FALSE
  }else{
    isNonObservationTimeDimension <- as.logical(isNonObservationTimeDimension)
  }
  
  isIdentityDimension = xmlGetAttr(xmlObj, "isIdentityDimension")
  if(is.null(isIdentityDimension)){
    isIdentityDimension <- FALSE
  }else{
    isIdentityDimension <- as.logical(isIdentityDimension)
  }
  
  crossSectionalAttachDataset = xmlGetAttr(xmlObj, "crossSectionalAttachDataset")
  if(is.null(crossSectionalAttachDataset)){
    crossSectionalAttachDataset <- NA
  }else{
    crossSectionalAttachDataset <- as.logical(crossSectionalAttachDataset)
  }
  
  crossSectionalAttachGroup = xmlGetAttr(xmlObj, "crossSectionalAttachGroup")
  if(is.null(crossSectionalAttachGroup)){
    crossSectionalAttachGroup <- NA
  }else{
    crossSectionalAttachGroup <- as.logical(crossSectionalAttachGroup)
  }
  
  crossSectionalAttachSection = xmlGetAttr(xmlObj, "crossSectionalAttachSection")
  if(is.null(crossSectionalAttachSection)){
    crossSectionalAttachSection <- NA
  }else{
    crossSectionalAttachSection <- as.logical(crossSectionalAttachSection)
  }
  
  crossSectionalAttachObservation = xmlGetAttr(xmlObj,
                                               "crossSectionalAttachObservation")
  if(is.null(crossSectionalAttachObservation)){
    crossSectionalAttachObservation <- NA
  }else{
    crossSectionalAttachObservation <- as.logical(crossSectionalAttachObservation)
  }
  
  #elements
  #========
  #TextFormat TODO
  
  #instantiate the object
  obj<- new("SDMXDimension",
            
            #attributes
            conceptRef = conceptRef,
            conceptVersion = conceptVersion,
            conceptAgency = conceptAgency,
            conceptSchemeRef = conceptSchemeRef,
            conceptSchemeAgency = conceptSchemeAgency,
            codelist = codelist,
            codelistVersion = codelistVersion,
            codelistAgency = codelistAgency,
            isMeasureDimension = isMeasureDimension,
            isFrequencyDimension = isFrequencyDimension,
            isEntityDimension = isEntityDimension,
            isCountDimension = isCountDimension,
            isNonObservationTimeDimension = isNonObservationTimeDimension,
            isIdentityDimension = isIdentityDimension,
            crossSectionalAttachDataset = crossSectionalAttachDataset,
            crossSectionalAttachGroup = crossSectionalAttachGroup,
            crossSectionalAttachSection = crossSectionalAttachSection,
            crossSectionalAttachObservation = crossSectionalAttachObservation
            
            #elements,
            #TextFormat = TextFormat
  )
}
