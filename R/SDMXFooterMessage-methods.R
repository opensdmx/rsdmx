# rsdmx - SDMXFooterMessage-methods
#
# Author: Emmanuel Blondel
#==========================

SDMXFooterMessage <- function(xmlObj){
  
  #code
  code <- xmlGetAttr(xmlObj,"code")
  if(is.null(code)) code <- as.character(NA)
  
  #severity
  severity <- xmlGetAttr(xmlObj, "severity")
  if(is.null(severity)) severity <- as.character(NA)
  
  #messages
  messages <- list()
  messagesXML <- xmlChildren(xmlObj)
  if(length(messagesXML) > 0){
    messages <- unname(lapply(messagesXML, xmlValue))
  }
  
  #SDMXFooterMessage object
  obj <- new("SDMXFooterMessage",
             code = code,
             severity = severity,
             messages = messages); 
  return(obj);
  
}
