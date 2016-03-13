#' @name SDMXDataStructures
#' @rdname SDMXDataStructures
#' @aliases SDMXDataStructures,SDMXDataStructures-method
#' 
#' @usage
#' SDMXDataStructures(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXDataStructures"
#' 
#' @seealso \link{readSDMX}
#'
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
  messageNsString <- "message"
  if(isRegistryInterfaceEnvelope(xmlObj, FALSE)) messageNsString <- "registry"
  messageNs <- findNamespace(namespaces, messageNsString)
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

#methods
as.data.frame.SDMXDataStructures <- function(x, ...){
  
  out <- do.call("rbind.fill",
                 lapply(x@datastructures,
                        function(ds){
                          
                          names <- slot(ds, "Name")
                          dsf.names <- as.data.frame(names, stringsAsFactors = FALSE)
                          colnames(dsf.names) <- paste0("Name.", colnames(dsf.names))
                          
                          desc <- slot(ds, "Description")
                          dsf.desc <- NULL
                          if(length(desc) > 0){
                            dsf.desc <- as.data.frame(desc, stringsAsFactors = FALSE)
                            colnames(dsf.desc) <- paste0("Description.", colnames(dsf.desc))
                          }
                          
                          dsf <- data.frame(
                              id = slot(ds, "id"),
                              agencyID = slot(ds, "agencyID"),
                              dsf.names,
                              stringsAsFactors = FALSE)
                          
                          if(!is.null(dsf.desc)){
                            dsf <- cbind(dsf, dsf.desc, stringsASFactors = FALSE)
                          }
                           
                          dsf <- cbind(dsf,
                                       version = slot(ds, "version"),
                                       uri = slot(ds, "uri"),
                                       urn = slot(ds, "urn"),
                                       isExternalReference = slot(ds, "isExternalReference"),
                                       isFinal = slot(ds, "isFinal"),
                                       validFrom = slot(ds, "validFrom"),
                                       validTo = slot(ds, "validTo"),
                                       stringsAsFactors = FALSE
                                       )
                              
                          
                          return(dsf)
                        })
                 )
  return(encodeSDMXOutput(out))
  
}

setAs("SDMXDataStructures", "data.frame",
      function(from) as.data.frame.SDMXDataStructures(from));