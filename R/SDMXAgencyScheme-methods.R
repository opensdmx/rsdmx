#' @name SDMXAgencyScheme
#' @rdname SDMXAgencyScheme
#' @aliases SDMXAgencyScheme,SDMXAgencyScheme-method
#' 
#' @usage
#' SDMXAgencyScheme(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXAgencyScheme"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXAgencyScheme <- function(xmlObj, namespaces){
  
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
  comNs <- findNamespace(namespaces, "common")
  agencyNamesXML <- getNodeSet(xmlDoc(xmlObj),
                                "//str:AgencyScheme/com:Name",
                                namespaces = c(str = as.character(strNs),
                                               com = as.character(comNs)))
  agencyNames <- list()
  if(length(agencyNamesXML) > 0){
    agencyNames <- new.env()
    sapply(agencyNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             agencyNames[[lang]] <- xmlValue(x)
           })
    agencyNames <- as.list(agencyNames)
  }
  
  #description (multi-languages)
  agencyDesXML <- getNodeSet(xmlDoc(xmlObj),
                              "//ns:AgencyScheme/ns:Description",
                              namespaces = strNs)
  agencyDescriptions <- list()
  if(length(agencyDesXML) > 0){
    agencyDescriptions <- new.env()
    sapply(agencyDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             agencyDescriptions[[lang]] <- xmlValue(x)
           })
    agencyDescriptions <- as.list(agencyDescriptions)
  }
  
  #agencies
  agenciesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Agency", namespaces = strNs)
  agencies <- list()
  if(length(agenciesXML) > 0){
    agencies <- lapply(agenciesXML, SDMXAgency, namespaces)
  }
  
  #instantiate the object
  obj<- new("SDMXAgencyScheme",
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
            #elements
            Name = agencyNames,
            Description = agencyDescriptions,
            agencies = agencies
  )
}
