#' @name SDMXDataFlows
#' @rdname SDMXDataFlows
#' @aliases SDMXDataFlows,SDMXDataFlows-method
#' 
#' @usage
#' SDMXDataFlows(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXDataFlows"
#' 
#' @seealso \link{readSDMX}
#'
SDMXDataFlows <- function(xmlObj, namespaces){
  new("SDMXDataFlows",
      SDMX(xmlObj, namespaces),
      dataflows = dataflows.SDMXDataFlows(xmlObj, namespaces)
  )
}

#get list of SDMXDataFlow
#=============================
dataflows.SDMXDataFlows <- function(xmlObj, namespaces){
  
  dataflows <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  messageNsString <- "message"
  if(isRegistryInterfaceEnvelope(xmlObj, FALSE)) messageNsString <- "registry"
  messageNs <- findNamespace(namespaces, messageNsString)
  strNs <- findNamespace(namespaces, "structure")
  
  dfXML <- NULL
  if(VERSION.21){
    dfXML <- getNodeSet(xmlObj,
                        "//mes:Structures/str:Dataflows/str:Dataflow",
                        namespaces = c(mes = as.character(messageNs),
                                       str = as.character(strNs)))
  }else{
    
    dfXML <- getNodeSet(xmlObj,
                        "//mes:Dataflows/str:Dataflow",
                        namespaces = c(mes = as.character(messageNs),
                                       str = as.character(strNs)))
    if(length(dfXML) == 0){
      dfXML <- getNodeSet(xmlObj,
                          "//mes:KeyFamilies/str:KeyFamily",
                          namespaces = c(mes = as.character(messageNs),
                                         str = as.character(strNs)))
    }
  }
  if(!is.null(dfXML)){
    dataflows <- lapply(dfXML, SDMXDataFlow, namespaces)
  }
  return(dataflows)
}

#methods
as.data.frame.SDMXDataFlows <- function(x, ...){
  
  out <- do.call("rbind.fill",
                 lapply(x@dataflows,
                        function(dataflow){
                          
                          names <- slot(dataflow, "Name")
                          dataflow.names <- as.data.frame(names, stringsAsFactors = FALSE)
                          colnames(dataflow.names) <- paste0("Name.", colnames(dataflow.names))
                          
                          desc <- slot(dataflow, "Description")
                          dataflow.desc <- NULL
                          if(length(desc) > 0){
                            dataflow.desc <- as.data.frame(desc, stringsAsFactors = FALSE)
                            colnames(dataflow.desc) <- paste0("Description.", colnames(dataflow.desc))
                          }
                          
                          df <- data.frame(
                            id = slot(dataflow, "id"),
                            agencyID = slot(dataflow, "agencyID"),
                            dataflow.names,
                            stringsAsFactors = FALSE)
                          
                          if(!is.null(dataflow.desc)){
                            df <- cbind(df, dataflow.desc, stringsAsFactors = FALSE)
                          }
                          
                          df <- cbind(df,
                                       version = slot(dataflow, "version"),
                                       uri = slot(dataflow, "uri"),
                                       urn = slot(dataflow, "urn"),
                                       isExternalReference = slot(dataflow, "isExternalReference"),
                                       isFinal = slot(dataflow, "isFinal"),
                                       validFrom = slot(dataflow, "validFrom"),
                                       validTo = slot(dataflow, "validTo"),
                                       dsdRef = slot(dataflow, "dsdRef"),
                                       stringsAsFactors = FALSE
                          )
                          
                          
                          return(df)
                        })
  )
  return(encodeSDMXOutput(out))
  
}

setAs("SDMXDataFlows", "data.frame",
      function(from) as.data.frame.SDMXDataFlows(from));