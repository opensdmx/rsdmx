# E.Blondel - 2014/08/21
#=======================

SDMXAttribute <- function(xmlObj){
  
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
  
  attachmentLevel = xmlGetAttr(xmlObj, "attachmentLevel")
  if(is.null(attachmentLevel)) attachmentLevel <- as.character(NA)
  
  assignmentStatus = xmlGetAttr(xmlObj, "assignmentStatus")
  if(is.null(assignmentStatus)) assignmentStatus <- as.character(NA)
  
  isTimeFormat = xmlGetAttr(xmlObj, "isTimeFormat")
  if(is.null(isTimeFormat)){
    isTimeFormat <- FALSE
  }else{
    isTimeFormat <- as.logical(isTimeFormat)
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
  
  
  isEntityAttribute = xmlGetAttr(xmlObj, "isEntityAttribute")
  if(is.null(isEntityAttribute)){
    isEntityAttribute <- FALSE
  }else{
    isEntityAttribute <- as.logical(isEntityAttribute)
  }
  
  isNonObservationTimeAttribute = xmlGetAttr(xmlObj,
                                             "isNonObservationTimeAttribute")
  if(is.null(isNonObservationTimeAttribute)){
    isNonObservationTimeAttribute <- FALSE
  }else{
    isNonObservationTimeAttribute <- as.logical(isNonObservationTimeAttribute)
  }
  
  isCountAttribute = xmlGetAttr(xmlObj, "isCountAttribute")
  if(is.null(isCountAttribute)){
    isCountAttribute <- FALSE
  }else{
    isCountAttribute <- as.logical(isCountAttribute)
  }
  
  isFrequencyAttribute = xmlGetAttr(xmlObj, "isFrequencyAttribute")
  if(is.null(isFrequencyAttribute)){
    isFrequencyAttribute <- FALSE
  }else{
    isFrequencyAttribute <- as.logical(isFrequencyAttribute)
  }
  
  isIdentityAttribute = xmlGetAttr(xmlObj, "isIdentityAttribute")
  if(is.null(isIdentityAttribute)){
    isIdentityAttribute <- FALSE
  }else{
    isIdentityAttribute <- as.logical(isIdentityAttribute)
  }
  
  
  #elements
  #========
  #TextFormat TODO
  
  #instantiate the object
  obj<- new("SDMXAttribute",
            
            #attributes
            conceptRef = conceptRef,
            conceptVersion = conceptVersion,
            conceptAgency = conceptAgency,
            conceptSchemeRef = conceptSchemeRef,
            conceptSchemeAgency = conceptSchemeAgency,
            codelist = codelist,
            codelistVersion = codelistVersion,
            codelistAgency = codelistAgency,
            attachmentLevel = attachmentLevel,
            assignmentStatus = assignmentStatus,
            isTimeFormat = isTimeFormat,
            crossSectionalAttachDataset = crossSectionalAttachDataset,
            crossSectionalAttachGroup = crossSectionalAttachGroup,
            crossSectionalAttachSection = crossSectionalAttachSection,
            crossSectionalAttachObservation = crossSectionalAttachObservation,
            isEntityAttribute = isEntityAttribute,
            isNonObservationTimeAttribute = isNonObservationTimeAttribute,
            isCountAttribute = isCountAttribute,
            isFrequencyAttribute = isFrequencyAttribute,
            isIdentityAttribute = isIdentityAttribute
            
            #elements,
            #TextFormat
            #AttachmentGroup
            #AttachmentMeasure
  )
}
