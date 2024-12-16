#' @name SDMXOrganisation
#' @rdname SDMXOrganisation
#' @aliases SDMXOrganisation,SDMXOrganisation-method
#' 
#' @usage
#' SDMXOrganisation(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXOrganisation"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXOrganisation <- function(xmlObj, namespaces){
  obj <- organisation.SDMXOrganisation(xmlObj, namespaces, "SDMXOrganisation")
}

organisation.SDMXOrganisation <- function(xmlObj, namespaces, klass){
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
  
  uri = xmlGetAttr(xmlObj, "uri")
  if(is.null(uri)) uri <- as.character(NA)
  
  urn = xmlGetAttr(xmlObj, "urn")
  if(is.null(urn)) urn <- as.character(NA)
  
  #elements
  #========
  #name (multi-languages)
  orgNamesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Name", namespaces = refNs)
  orgNames <- NULL
  if(length(orgNamesXML) > 0){
    orgNames <- new.env()
    sapply(orgNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             orgNames[[lang]] <- xmlValue(x)
           })
    orgNames <- as.list(orgNames)
  }
  
  #description (multi-languages)
  orgDesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Description", namespaces = refNs)
  orgDescriptions <- list()
  if(length(orgDesXML) > 0){
    orgDescriptions <- new.env()
    sapply(orgDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             orgDescriptions[[lang]] <- xmlValue(x)
           })
    orgDescriptions <- as.list(orgDescriptions)
  }
  
  #instantiate the object
  obj<- new(klass,
            #attributes
            id = id,
            uri = uri,
            urn = urn,
            
            #elements
            Name = orgNames,
            Description = orgDescriptions
  )
  return(obj)
}