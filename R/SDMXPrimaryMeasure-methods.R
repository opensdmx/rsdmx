# E.Blondel - 2014/08/21
#=======================

SDMXPrimaryMeasure <- function(xmlObj){
  
  sdmxVersion <- version.SDMXSchema(xmlDoc(xmlObj))
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlDoc(xmlObj))
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  #attributes
  #=========
  conceptRef = xmlGetAttr(xmlObj, "conceptRef")
  if(is.null(conceptRef)) conceptRef <- as.character(NA)
  
  conceptVersion = xmlGetAttr(xmlObj, "conceptVersion")
  if(is.null(conceptVersion)) conceptVersion <- as.character(NA)
  
  conceptAgency = xmlGetAttr(xmlObj, "conceptAgency")
  if(is.null(conceptAgency)) conceptAgency <- as.character(NA)
  
  conceptSchemeRef = xmlGetAttr(xmlObj, "conceptSchemeRef")
  if(is.null(conceptSchemeRef)) conceptSchemeRef <- as.character(NA)
  
  conceptSchemeAgency = xmlGetAttr(xmlObj, "conceptSchemeAgency")
  if(is.null(conceptSchemeAgency)) conceptSchemeAgency <- as.character(NA)
  
  codelist = xmlGetAttr(xmlObj, "codelist")
  if(is.null(codelist)) codelist <- as.character(NA)
  
  codelistVersion = xmlGetAttr(xmlObj, "codelistVersion")
  if(is.null(codelistVersion)) codelistVersion <- as.character(NA)
  
  codelistAgency = xmlGetAttr(xmlObj, "codelistAgency")
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
