# E.Blondel - 2014/08/03
#=======================

SDMXStructureType <- function(xmlObj){
	new("SDMXStructureType",
      SDMXType(xmlObj),
      subtype = type.SDMXStructureType(xmlObj));
}

type.SDMXStructureType <- function(xmlObj){
  
  namespaces <- namespaces.SDMX(xmlObj)
  messageNs <- findNamespace(namespaces, "message")
  
  structuresXML <- getNodeSet(xmlObj, "//ns:Structures", namespaces = messageNs)
  if(length(structuresXML) == 0){
    return("SDMXDataStructure")
  }else{
    strType <- paste("SDMX", xmlName(xmlChildren(structuresXML[[1]])[[1]]), sep="") 
    return(strType)
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

