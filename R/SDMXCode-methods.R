#' @name SDMXCode
#' @rdname SDMXCode
#' @aliases SDMXCode,SDMXCode-method
#' 
#' @usage
#' SDMXCode(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXCode"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXCode <- function(xmlObj, namespaces){
  
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
  id <- NULL
  if(VERSION.21){
    id <- xmlGetAttr(xmlObj, "id")
  }else{
    id <- xmlGetAttr(xmlObj, "value")
  }
  if(is.null(id)) id <- as.character(NA)
  
  urn = xmlGetAttr(xmlObj, "urn")
  if(is.null(urn)) urn <- as.character(NA)
  
  parentCode <- as.character(NA)
  parentId <- xmlGetAttr(xmlObj, "parentCode")
  if(!is.null(parentId)) parentCode <- parentId
  parentNode <- getNodeSet(xmlDoc(xmlObj), "//ns:Parent//Ref", namespaces = strNs)
  if(length(parentNode) == 1) parentCode <- xmlGetAttr(parentNode[[1]], "id")
  if(length(parentNode)  > 1) {
    parentCode <- sapply(parentNode, function(x) { xmlGetAttr(x, "id") })
    # we collapse the vector of parent codes into a single string as required by the SDMXCode class
    parentCode <- paste(parentCode, collapse = ",")
  }
  
  #elements
  #========
  # Labels - name /description (multi-languages) DEPRECATED
  codeLabelsXML <- NULL
  if(VERSION.21){
    codeLabelsXML <- getNodeSet(xmlDoc(xmlObj),
                                "//ns:Name", namespaces = refNs)
  }else{
    codeLabelsXML <- getNodeSet(xmlDoc(xmlObj),
                                "//ns:Description", namespaces = refNs)
  }
  codeLabels <- list()
  if(length(codeLabelsXML) > 0){
    codeLabels <- new.env()
    sapply(codeLabelsXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             codeLabels[[lang]] <- xmlValue(x)
           })
    codeLabels <- as.list(codeLabels)
  }
  
  # Names (multi-languages)
  codeNamesXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Name", namespaces = refNs)
  codeNames <- list()
  if(length(codeNamesXML) > 0){
    codeNames <- new.env()
    sapply(codeNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             codeNames[[lang]] <- xmlValue(x)
           })
    codeNames <- as.list(codeNames)
  }
  
  # Descriptions (multi-languages)
  codeDescriptionsXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Description", namespaces = refNs)
  codeDescriptions <- list()
  if(length(codeDescriptionsXML) > 0){
    codeDescriptions <- new.env()
    sapply(codeDescriptionsXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             codeDescriptions[[lang]] <- xmlValue(x)
           })
    codeDescriptions <- as.list(codeDescriptions)
  }
  
  #instantiate the object
  obj<- new("SDMXCode",
            
            #attributes
            id = id, #equivalent to "value" in SDMX 2.0
            urn = urn,
            parentCode = parentCode,
  
            #elements
            label = codeLabels,
            name = codeNames,
            description = codeDescriptions
  )
}
