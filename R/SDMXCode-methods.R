# E.Blondel - 2014/08/20
#=======================

SDMXCode <- function(xmlObj){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
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
  
  parentCode = xmlGetAttr(xmlObj, "parentCode")
  if(is.null(parentCode)) parentCode <- as.character(NA)
  
  #elements
  #========
  # Labels - name /description (multi-languages)
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
             codeLabels[[lang]] <- xmlValue(x)
           })
    codeLabels <- as.list(codeLabels)
  }  
  
  #instantiate the object
  obj<- new("SDMXCode",
            
            #attributes
            id = id, #equivalent to "value" in SDMX 2.0
            urn = urn,
            parentCode = parentCode,
  
            #elements
            label = codeLabels
  )
}
