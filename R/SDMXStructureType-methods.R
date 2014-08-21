# E.Blondel - 2014/08/03
#=======================

SDMXStructureType <- function(xmlObj){
	new("SDMXStructureType",
      SDMXType(xmlObj),
      subtype = type.SDMXStructureType(xmlObj));
}

type.SDMXStructureType <- function(xmlObj){
  
  sdmxVersion <- version.SDMXSchema(xmlObj)
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlObj)
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  if(VERSION.21){
    dsXML <- getNodeSet(xmlObj, "//ns:DataStructures", namespaces = strNs)
    ccXML <- getNodeSet(xmlObj, "//ns:Concepts", namespaces = strNs)
    clXML <- getNodeSet(xmlObj, "//ns:CodeLists", namespaces = strNs)   
    if(all(c(length(dsXML)>0,length(ccXML)>0,length(clXML)>0))){
      return("DataStructureDefinitionsType")
    }else{
      #others
      structuresXML <- getNodeSet(xmlObj, "//ns:Structures", namespaces = messageNs)
      strType <- paste(xmlName(xmlChildren(structuresXML[[1]])[[1]]), "Type", sep="") 
      return(strType)
    }
  }else{
    dsXML <- getNodeSet(xmlObj, "//ns:KeyFamilies", namespaces = messageNs)
    ccXML <- getNodeSet(xmlObj, "//ns:Concepts", namespaces = messageNs)
    clXML <- getNodeSet(xmlObj, "//ns:CodeLists", namespaces = messageNs)
    if(all(c(length(dsXML)>0, length(ccXML)>0, length(clXML)>0))){
      #DSD
      return("DataStructureDefinitionsType")
    }else{
      #others
      if(length(ccXML)>0) return("ConceptsType")
      if(length(clXML)>0) return("CodelistsType")
      if(length(dsXML)>0) return("DataStructuresType")
    }
  }
  return(NULL)
}

#generics
if (!isGeneric("getStructureType"))
	setGeneric("getStructureType", function(obj) standardGeneric("getStructureType"));

#methods
setMethod(f = "getStructureType", signature = "SDMXStructureType", function(obj){
            return(obj@subtype)
          })

