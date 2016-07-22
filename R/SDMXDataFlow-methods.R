#' @name SDMXDataFlow
#' @rdname SDMXDataFlow
#' @aliases SDMXDataFlow,SDMXDataFlow-method
#' 
#' @usage
#' SDMXDataFlow(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXDataFlow"
#' 
#' @seealso \link{readSDMX}
#'
SDMXDataFlow <- function(xmlObj, namespaces){
  
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
  flowNamesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    flowNamesXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:Dataflow/com:Name",
                             namespaces = c(str = as.character(strNs),
                                            com = as.character(comNs)))
  }else{
    
    flowNamesXML <- getNodeSet(xmlDoc(xmlObj),
                               "//str:Dataflow/str:Name",
                               namespaces = c(str = as.character(strNs)))
    if(length(flowNamesXML) == 0){
      flowNamesXML <- getNodeSet(xmlDoc(xmlObj),
                             "//str:KeyFamily/str:Name",
                             namespaces = c(str = as.character(strNs)))
    }
  }
  flowNames <- NULL
  if(length(flowNamesXML) > 0){
    flowNames <- new.env()
    sapply(flowNamesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             flowNames[[lang]] <- xmlValue(x)
           })
    flowNames <- as.list(flowNames)
  }
  
  #description (multi-languages)
  flowDesXML <- NULL
  if(VERSION.21){
    comNs <- findNamespace(namespaces, "common")
    flowDesXML <- getNodeSet(xmlDoc(xmlObj),
                           "//str:Dataflow/com:Description",
                           namespaces = c(str = as.character(strNs),
                                          com = as.character(comNs)))
  }else{
    
    flowDesXML <- getNodeSet(xmlDoc(xmlObj),
                               "//str:Dataflow/str:Description",
                               namespaces = c(str = as.character(strNs)))
    if(length(flowDesXML) == 0){
      flowDesXML <- getNodeSet(xmlDoc(xmlObj),
                               "//str:KeyFamily/str:Description",
                               namespaces = c(str = as.character(strNs)))
    }
  }  
  flowDescriptions <- list()
  if(length(flowDesXML) > 0){
    flowDescriptions <- new.env()
    sapply(flowDesXML,
           function(x){
             lang <- xmlGetAttr(x,"xml:lang")
             if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
             if(is.null(lang)) lang <- "default"
             flowDescriptions[[lang]] <- xmlValue(x)
           })
    flowDescriptions <- as.list(flowDescriptions)
  }
  
  #dsd reference
  dsdRef <- as.character(NA)
  if(VERSION.21){
    flowStr <- getNodeSet(xmlDoc(xmlObj), "//str:Dataflow/str:Structure",
                          namespaces = c(str = as.character(strNs)))
    if(length(flowStr) > 0){
     flowStr <- flowStr[[1]]
     dsdRef <- xmlGetAttr(xmlChildren(flowStr)[[1]], "id")
    }
  }else{
    dsdRef <- NULL
    kfRefXML <- getNodeSet(xmlDoc(xmlObj), "//str:Dataflow/str:KeyFamilyRef",
                           namespaces = c(str = as.character(strNs)))
    if(length(kfRefXML) > 0){
      kfRefXML <- kfRefXML[[1]]
      children <- xmlChildren(kfRefXML)
      if("KeyFamilyID" %in% names(children)){
        dsdRef <- xmlValue(children$KeyFamilyID)
      }
    }
    if(is.null(dsdRef)) dsdRef <- id
  }
  
  #instantiate the object
  obj<- new("SDMXDataFlow",    
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
            Name = flowNames,
            Description = flowDescriptions,
            dsdRef = dsdRef
  )
}
