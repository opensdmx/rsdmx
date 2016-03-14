#' @name SDMXDataStructure
#' @rdname SDMXDataStructure
#' @aliases SDMXDataStructure,SDMXDataStructure-method
#' 
#' @usage
#' SDMXDataStructure(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXDataStructure"
#' 
#' @seealso \link{readSDMX}
#'
SDMXDataStructure <- function(xmlObj, namespaces){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
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
  dsNamesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    dsNamesXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:DataStructure/com:Name",
                             namespaces = c(str = as.character(strNs),
                                            com = as.character(comNs)))
  }else{
    dsNamesXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:KeyFamily/str:Name",
                             namespaces = c(str = as.character(strNs)))
  }
  dsNames <- NULL
  if(length(dsNamesXML) > 0){
    dsNames <- new.env()
    sapply(dsNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             dsNames[[lang]] <- xmlValue(x)
           })
    dsNames <- as.list(dsNames)
  }
  
  #description (multi-languages)
  dsDesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    dsDesXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:DataStructure/com:Description",
                           namespaces = c(str = as.character(strNs),
                                          com = as.character(comNs)))
  }else{
    dsDesXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:KeyFamily/str:Description",
                           namespaces = c(str = as.character(strNs)))
  }
  
  dsDescriptions <- list()
  if(length(dsDesXML) > 0){
    dsDescriptions <- new.env()
    sapply(dsDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             dsDescriptions[[lang]] <- xmlValue(x)
           })
    dsDescriptions <- as.list(dsDescriptions)
  }
  
  #Components
  compXML <- NULL
  if(VERSION.21){
    compXML <- getNodeSet(xmlDoc(xmlObj),
                          "//str:DataStructureComponents",
                          namespaces = c(str = as.character(strNs)))
  }else{
    compXML <- getNodeSet(xmlDoc(xmlObj),
                          "//str:Components",
                          namespaces = c(str = as.character(strNs)))
  }
  components <- NULL
  if(length(compXML) > 0) components <- SDMXComponents(xmlObj, namespaces)
  
  #instantiate the object
  obj<- new("SDMXDataStructure",    
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
            Name = dsNames,
            Description = dsDescriptions,
            Components = components
  )
}
