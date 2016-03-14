#' @name SDMXDimension
#' @rdname SDMXDimension
#' @aliases SDMXDimension,SDMXDimension-method
#' 
#' @usage
#' SDMXDimension(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXDimension"
#' 
#' @seealso \link{readSDMX}
#'
SDMXDimension <- function(xmlObj, namespaces){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  #manage SDMX 2.1 conceptIdentity and codelist LocalRepresentation
  conceptRefXML <- NULL
  if(VERSION.21){
    conceptIdentityXML <- getNodeSet(xmlDoc(xmlObj),
                                  "//str:ConceptIdentity",
                                  namespaces = c(str = as.character(strNs)))
    if(length(conceptIdentityXML) > 0)
      conceptRefXML <- xmlChildren(conceptIdentityXML[[1]])[[1]]
  }
  
  codelistRefXML <- NULL
  if(VERSION.21){
    enumXML <- getNodeSet(xmlDoc(xmlObj),
                                     "//str:Enumeration",
                                     namespaces = c(str = as.character(strNs)))
    if(length(enumXML) > 0)
      codelistRefXML <- xmlChildren(enumXML[[1]])[[1]]
  }
  
  #attributes
  #=========
  conceptRef <- NULL
  conceptVersion <- NULL
  conceptAgency <- NULL
  conceptSchemeRef <- NULL
  conceptSchemeAgency <- NULL
  codelist <- NULL
  codelistVersion <- NULL
  codelistAgency <- NULL
  isMeasureDimension <- NULL
  isFrequencyDimension <- NULL
  isEntityDimension <- NULL
  isCountDimension <- NULL
  isNonObservationTimeDimension <- NULL
  isIdentityDimension <- NULL
  crossSectionalAttachDataset <- NULL
  crossSectionalAttachGroup <- NULL
  crossSectionalAttachSection <- NULL
  crossSectionalAttachObservation <- NULL
  
  if(VERSION.21){
    #concepts
    if(!is.null(conceptRefXML)){
      conceptRef = xmlGetAttr(conceptRefXML, "id")
      conceptVersion = xmlGetAttr(conceptRefXML, "maintainableParentVersion")
      conceptAgency = xmlGetAttr(conceptRefXML, "agencyID")
      #TODO conceptSchemeRef?
      #TODO conceptSchemeAgency
    }
    
    #codelists
    if(!is.null(codelistRefXML)){
      codelist <- xmlGetAttr(codelistRefXML, "id")
      codelistVersion <- xmlGetAttr(codelistRefXML, "version")
      codelistAgency <- xmlGetAttr(codelistRefXML, "agencyID")
    }
    
    #dimension characteristics
    #TODO isMeasureDimension?
    #TODO isFrequencyDimension?
    #TODO isEntityDimension?
    #TODO isLogicalDimension?
    #TODO isNonObservationTimeDimension?
    #TODO isIdentityDimension?
    
    #crossSectionalAttach
    #TODO crossSectionalAttachDataset?
    #TODO crossSectionalAttachGroup?
    #TODO crossSectionalAttachSection?
    #TODO crossSectionalAttachObservation?
    
  }else{
    #concepts
    conceptRef = xmlGetAttr(xmlObj, "conceptRef")
    conceptVersion = xmlGetAttr(xmlObj, "conceptVersion")
    conceptAgency = xmlGetAttr(xmlObj, "conceptAgency")
    conceptSchemeRef = xmlGetAttr(xmlObj, "conceptSchemeRef")    
    conceptSchemeAgency = xmlGetAttr(xmlObj, "conceptSchemeAgency")
    
    #codelists
    codelist = xmlGetAttr(xmlObj, "codelist")
    codelistVersion = xmlGetAttr(xmlObj, "codelistVersion")    
    codelistAgency = xmlGetAttr(xmlObj, "codelistAgency")
    
    #dimensions characteristics
    isMeasureDimension = xmlGetAttr(xmlObj, "isMeasureDimension")
    isFrequencyDimension = xmlGetAttr(xmlObj, "isFrequencyDimension")
    isEntityDimension = xmlGetAttr(xmlObj, "isEntityDimension")
    isCountDimension = xmlGetAttr(xmlObj, "isCountDimension")
    isNonObservationTimeDimension = xmlGetAttr(xmlObj,"isNonObservationTimeDimension")
    isIdentityDimension = xmlGetAttr(xmlObj, "isIdentityDimension")
    
    #crossSectionalAttach
    crossSectionalAttachDataset = xmlGetAttr(xmlObj, "crossSectionalAttachDataset")
    crossSectionalAttachGroup = xmlGetAttr(xmlObj, "crossSectionalAttachGroup")
    crossSectionalAttachSection = xmlGetAttr(xmlObj, "crossSectionalAttachSection")
    crossSectionalAttachObservation = xmlGetAttr(xmlObj,"crossSectionalAttachObservation")
  }
  
  if(is.null(conceptRef)) conceptRef <- as.character(NA)
  if(is.null(conceptVersion)) conceptVersion <- as.character(NA)
  if(is.null(conceptAgency)) conceptAgency <- as.character(NA)
  if(is.null(conceptSchemeRef)) conceptSchemeRef <- as.character(NA)
  if(is.null(conceptSchemeAgency)) conceptSchemeAgency <- as.character(NA)
  
  if(is.null(codelist)) codelist <- as.character(NA)
  if(is.null(codelistVersion)) codelistVersion <- as.character(NA)
  if(is.null(codelistAgency)) codelistAgency <- as.character(NA)
  
  if(is.null(isMeasureDimension)){
    isMeasureDimension <- FALSE
  }else{
    isMeasureDimension <- as.logical(isMeasureDimension)
  }

  if(is.null(isFrequencyDimension)){
    isFrequencyDimension <- FALSE
  }else{
    isFrequencyDimension <- as.logical(isFrequencyDimension)
  }
  
  if(is.null(isEntityDimension)){
    isEntityDimension <- FALSE
  }else{
    isEntityDimension <- as.logical(isEntityDimension)
  }
  
  if(is.null(isCountDimension)){
    isCountDimension <- FALSE
  }else{
    isCountDimension <- as.logical(isCountDimension)
  }
  
  if(is.null(isNonObservationTimeDimension)){
    isNonObservationTimeDimension <- FALSE
  }else{
    isNonObservationTimeDimension <- as.logical(isNonObservationTimeDimension)
  }
  
  if(is.null(isIdentityDimension)){
    isIdentityDimension <- FALSE
  }else{
    isIdentityDimension <- as.logical(isIdentityDimension)
  }
  
  if(is.null(crossSectionalAttachDataset)){
    crossSectionalAttachDataset <- NA
  }else{
    crossSectionalAttachDataset <- as.logical(crossSectionalAttachDataset)
  }
  
  if(is.null(crossSectionalAttachGroup)){
    crossSectionalAttachGroup <- NA
  }else{
    crossSectionalAttachGroup <- as.logical(crossSectionalAttachGroup)
  }
  
  if(is.null(crossSectionalAttachSection)){
    crossSectionalAttachSection <- NA
  }else{
    crossSectionalAttachSection <- as.logical(crossSectionalAttachSection)
  }
  
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
