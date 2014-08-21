# E.Blondel - 2014/08/20
#=======================

SDMXDataStructures <- function(xmlObj){
  new("SDMXDataStructures",
      SDMX(xmlObj),
      datastructures = datastructures.SDMXDataStructures(xmlObj)
  )
}

#get list of SDMXDataStructure
#=============================
datastructures.SDMXDataStructures <- function(xmlObj){
  
  datastructures <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlObj)
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlObj)
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
  dsXML <- NULL
  if(VERSION.21){
    dsXML <- getNodeSet(xmlObj,
                        "//mes:Structures/str:DataStructures/str:DataStructure",
                        namespaces = c(mes = as.character(messageNs),
                                       str = as.character(strNs)))
  }else{
    dsXML <- getNodeSet(xmlObj,
                        "//mes:KeyFamilies/str:KeyFamily",
                        namespaces = c(mes = as.character(messageNs),
                                       str = as.character(strNs)))
  }
  if(!is.null(dsXML)){
    datastructures <- lapply(dsXML, function(x){ SDMXDataStructure(x)})
  }
  return(datastructures)
}

