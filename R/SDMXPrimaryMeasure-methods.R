#' @name SDMXPrimaryMeasure
#' @rdname SDMXPrimaryMeasure
#' @aliases SDMXPrimaryMeasure,SDMXPrimaryMeasure-method
#' 
#' @usage
#' SDMXPrimaryMeasure(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXPrimaryMeasure"
#' 
#' @seealso \link{readSDMX}
#'
SDMXPrimaryMeasure <- function(xmlObj, namespaces){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj), namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  #manage SDMX 2.1 conceptIdentity and codelist LocalRepresentation
  conceptRefXML <- NULL
  if(VERSION.21){
    conceptIdentityXML <- getNodeSet(xmlDoc(xmlObj),
                                     "//str:ConceptIdentity",
                                     namespaces = c(str = as.character(strNs)))
    if(length(conceptIdentityXML) > 0)
      conceptRefXML <- xmlChildren(conceptIdentityXML[[1]])[[1]]
  }
  
  codelistRefXML <- NULL
  if(VERSION.21){
    enumXML <- getNodeSet(xmlDoc(xmlObj),
                          "//str:Enumeration",
                          namespaces = c(str = as.character(strNs)))
    if(length(enumXML) > 0)
      codelistRefXML <- xmlChildren(enumXML[[1]])[[1]]
  }
  
  #attributes
  #=========
  conceptRef <- NULL
  conceptVersion <- NULL
  conceptAgency <- NULL
  conceptSchemeRef <- NULL
  conceptSchemeAgency <- NULL
  codelist <- NULL
  codelistVersion <- NULL
  codelistAgency <- NULL
  
  if(VERSION.21){
    #concepts
    if(!is.null(conceptRefXML)){
      conceptRef = xmlGetAttr(conceptRefXML, "id")
      conceptVersion = xmlGetAttr(conceptRefXML, "maintainableParentVersion")
      conceptAgency = xmlGetAttr(conceptRefXML, "agencyID")
      #TODO conceptSchemeRef?
      #TODO conceptSchemeAgency
    }
    
    #codelists
    if(!is.null(codelistRefXML)){
      codelist <- xmlGetAttr(codelistRefXML, "id")
      codelistVersion <- xmlGetAttr(codelistRefXML, "version")
      codelistAgency <- xmlGetAttr(codelistRefXML, "agencyID")
    }
    
  }else{
    #concepts
    conceptRef = xmlGetAttr(xmlObj, "conceptRef")
    conceptVersion = xmlGetAttr(xmlObj, "conceptVersion")
    conceptAgency = xmlGetAttr(xmlObj, "conceptAgency")
    conceptSchemeRef = xmlGetAttr(xmlObj, "conceptSchemeRef")    
    conceptSchemeAgency = xmlGetAttr(xmlObj, "conceptSchemeAgency")
    
    #codelists
    codelist = xmlGetAttr(xmlObj, "codelist")
    codelistVersion = xmlGetAttr(xmlObj, "codelistVersion")    
    codelistAgency = xmlGetAttr(xmlObj, "codelistAgency")

  }
  
  if(is.null(conceptRef)) conceptRef <- as.character(NA)
  if(is.null(conceptVersion)) conceptVersion <- as.character(NA)
  if(is.null(conceptAgency)) conceptAgency <- as.character(NA)
  if(is.null(conceptSchemeRef)) conceptSchemeRef <- as.character(NA)
  if(is.null(conceptSchemeAgency)) conceptSchemeAgency <- as.character(NA)
  
  if(is.null(codelist)) codelist <- as.character(NA)
  if(is.null(codelistVersion)) codelistVersion <- as.character(NA)
  if(is.null(codelistAgency)) codelistAgency <- as.character(NA)
  
  #elements
  #========
  #TextFormat TODO
  
  #instantiate the object
  obj<- new("SDMXPrimaryMeasure",
            
            #attributes
            conceptRef = conceptRef,
            conceptVersion = conceptVersion,
            conceptAgency = conceptAgency,
            conceptSchemeRef = conceptSchemeRef,
            conceptSchemeAgency = conceptSchemeAgency,
            codelist = codelist,
            codelistVersion = codelistVersion,
            codelistAgency = codelistAgency
            
            #elements,
            #TextFormat = TextFormat
  )
}
