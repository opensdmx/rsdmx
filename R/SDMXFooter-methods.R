# rsdmx - SDMXFooter-methods
#
# Author: Emmanuel Blondel
#==========================

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

