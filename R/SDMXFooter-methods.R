#' @name SDMXFooter
#' @rdname SDMXFooter
#' @aliases SDMXFooter,SDMXFooter-method
#' 
#' @usage
#' SDMXFooter(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXFooter"
#' 
#' @seealso \link{readSDMX}

SDMXFooter <- function(xmlObj){
  
  messageList = list()
  
  #check presence of footer
  nsDefs.df <- namespaces.SDMX(xmlObj)
  
  ns <- findNamespace(nsDefs.df, "footer")
  if(length(ns) > 0){
    messageListXML <- getNodeSet(xmlObj,
                                "//footer:Message",
                                namespaces = c(footer = as.character(ns)))
    messageList <- lapply(messageListXML, SDMXFooterMessage)
  }

  #SDMXFooter object
  obj <- new("SDMXFooter", messages = messageList); 
  return(obj);
  
}

