#' @name SDMXConcept
#' @rdname SDMXConcept
#' @aliases SDMXConcept,SDMXConcept-method
#' 
#' @usage
#' SDMXConcept(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXConcept"
#' 
#' @seealso \link{readSDMX}
#'
SDMXConcept <- function(xmlObj, namespaces){

  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  refNs <- strNs
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    refNs <- comNs
  }
  
  #attributes
  #=========
  id = xmlGetAttr(xmlObj, "id")
  if(is.null(id)) id <- as.character(NA)

  agencyId = xmlGetAttr(xmlObj, "agencyID")
  if(is.null(agencyId)) agencyId <- as.character(NA)
  
  version = xmlGetAttr(xmlObj, "version")
  if(is.null(version)) version <- as.character(NA)
  
  uri = xmlGetAttr(xmlObj, "uri")
  if(is.null(uri)) uri <- as.character(NA)
  
  urn = xmlGetAttr(xmlObj, "urn")
  if(is.null(urn)) urn <- as.character(NA)
  
  isExternalReference = xmlGetAttr(xmlObj, "isExternalReference")
  if(is.null(isExternalReference)){
    isExternalReference <- NA
  }else{
    isExternalReference <- as.logical(isExternalReference)
  }
  
  coreRepresentation = xmlGetAttr(xmlObj, "coreRepresentation")
  if(is.null(coreRepresentation)) coreRepresentation <- as.character(NA)
  
  coreRepresentationAgency = xmlGetAttr(xmlObj, "coreRepresentationAgency")
  if(is.null(coreRepresentationAgency)) coreRepresentationAgency <- as.character(NA)
  
  parent = xmlGetAttr(xmlObj, "parent")
  if(is.null(parent)) parent <- as.character(NA)
  
  parentAgency = xmlGetAttr(xmlObj, "parentAgency")
  if(is.null(parentAgency)) parentAgency <- as.character(NA)

  #elements
  #========
  #name (multi-languages)
  conceptNamesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Name", namespaces = refNs)
  conceptNames <- NULL
  if(length(conceptNamesXML) > 0){
    conceptNames <- new.env()
    sapply(conceptNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             conceptNames[[lang]] <- xmlValue(x)
           })
    conceptNames <- as.list(conceptNames)
  }

  #description (multi-languages)
  conceptDesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Description", namespaces = refNs)
  conceptDescriptions <- list()
  if(length(conceptDesXML) > 0){
    conceptDescriptions <- new.env()
    sapply(conceptDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             conceptDescriptions[[lang]] <- xmlValue(x)
           })
    conceptDescriptions <- as.list(conceptDescriptions)
  }  
  
  #instantiate the object
  obj<- new("SDMXConcept",
      
      #attributes
      id = id,
      agencyID = agencyId,
      version = version,
      uri = uri,
      urn = urn,
      isExternalReference = isExternalReference,
      coreRepresentation = coreRepresentation,
      coreRepresentationAgency = coreRepresentationAgency,
      parent = parent,
      parentAgency = parentAgency,
      
      #elements
      Name = conceptNames,
      Description = conceptDescriptions
  )
}
