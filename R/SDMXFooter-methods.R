#' @name SDMXFooter
#' @rdname SDMXFooter
#' @aliases SDMXFooter,SDMXFooter-method
#' 
#' @usage
#' SDMXFooter(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXFooter"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXFooter <- function(xmlObj, namespaces){
  
  messageList = list()
  
  #check presence of footer
  
  ns <- findNamespace(namespaces, "footer")
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

