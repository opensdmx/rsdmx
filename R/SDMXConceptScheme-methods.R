#' @name SDMXConceptScheme
#' @rdname SDMXConceptScheme
#' @aliases SDMXConceptScheme,SDMXConceptScheme-method
#' 
#' @usage
#' SDMXConceptScheme(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXConceptScheme"
#' 
#' @seealso \link{readSDMX}
#'
SDMXConceptScheme <- function(xmlObj, namespaces){
  
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")  
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
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
  
  isFinal = xmlGetAttr(xmlObj, "isFinal")
  if(is.null(isFinal)){
    isFinal <- NA
  }else{
    isFinal <- as.logical(isFinal)
  }
  
  validFrom = xmlGetAttr(xmlObj,"validFrom")
  if(is.null(validFrom)) validFrom <- as.character(NA)
  
  validTo = xmlGetAttr(xmlObj, "validTo")
  if(is.null(validTo)) validTo <- as.character(NA)
  
  #elements
  #========
  #name (multi-languages)
  conceptNamesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    conceptNamesXML <- getNodeSet(xmlDoc(xmlObj),
                                  "//str:ConceptScheme/com:Name",
                                  namespaces = c(str = as.character(strNs),
                                                 com = as.character(comNs)))
  }else{
    conceptNamesXML <- getNodeSet(xmlDoc(xmlObj),
                                  "//str:ConceptScheme/str:Name",
                                  namespaces = c(str = as.character(strNs)))
  }
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
  conceptDesXML <- getNodeSet(xmlDoc(xmlObj),
                              "//ns:ConceptScheme/ns:Description",
                              namespaces = strNs)
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
  
  #concepts
  conceptsXML <- getNodeSet(xmlDoc(xmlObj),
                            "//ns:Concept",
                            namespaces = strNs)
  concepts <- list()
  if(length(conceptsXML) > 0){
    concepts <- lapply(conceptsXML, SDMXConcept, namespaces)
  }
  
  #instantiate the object
  obj<- new("SDMXConceptScheme",
            
            #attributes
            id = id,
            agencyID = agencyId,
            version = version,
            uri = uri,
            urn = urn,
            isExternalReference = isExternalReference,
            isFinal = isFinal,
            validFrom = validFrom,
            validTo = validTo,
            
            #elements,
            Name = conceptNames,
            Description = conceptDescriptions,
            Concept = concepts
  )
}
