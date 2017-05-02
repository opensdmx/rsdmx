#' @name SDMXCodelist
#' @rdname SDMXCodelist
#' @aliases SDMXCodelist,SDMXCodelist-method
#' 
#' @usage
#' SDMXCodelist(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXCodelist"
#' 
#' @seealso \link{readSDMX}
#'
SDMXCodelist <- function(xmlObj, namespaces){
  
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
  codelistNamesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    codelistNamesXML <- getNodeSet(xmlDoc(xmlObj),
                                  "//str:Codelist/com:Name",
                                  namespaces = c(str = as.character(strNs),
                                                 com = as.character(comNs)))
  }else{
    codelistNamesXML <- getNodeSet(xmlDoc(xmlObj),
                                  "//str:CodeList/str:Name",
                                  namespaces = c(str = as.character(strNs)))
  }
  codelistNames <- list()
  if(length(codelistNamesXML) > 0){
    codelistNames <- new.env()
    sapply(codelistNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             codelistNames[[lang]] <- xmlValue(x)
           })
    codelistNames <- as.list(codelistNames)
  }
  
  #description (multi-languages)
  codelistDesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    codelistDesXML <- getNodeSet(xmlDoc(xmlObj),
                                   "//str:Codelist/com:Description",
                                   namespaces = c(str = as.character(strNs),
                                                  com = as.character(comNs)))
  }else{
    codelistDesXML <- getNodeSet(xmlDoc(xmlObj),
                                   "//str:CodeList/str:Description",
                                   namespaces = c(str = as.character(strNs)))
  }
  
  codelistDescriptions <- list()
  if(length(codelistDesXML) > 0){
    codelistDescriptions <- new.env()
    sapply(codelistDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             codelistDescriptions[[lang]] <- xmlValue(x)
           })
    codelistDescriptions <- as.list(codelistDescriptions)
  }
  
  #concepts
  codesXML <- NULL
  if(VERSION.21){
    codesXML <- getNodeSet(xmlDoc(xmlObj),
                            "//ns:Codelist/ns:Code",
                            namespaces = strNs)
  }else{
    codesXML <- getNodeSet(xmlDoc(xmlObj),
                           "//ns:CodeList/ns:Code",
                           namespaces = strNs)
  }
  
  codes <- list()
  if(length(codesXML) > 0){
    codes <- lapply(codesXML, SDMXCode, namespaces)
  }
  
  #instantiate the object
  obj<- new("SDMXCodelist",
            
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
            Name = codelistNames,
            Description = codelistDescriptions,
            Code = codes
  )
}
