# constructor
# E.Blondel - 2013/06/09
#=======================

SDMX <- function(xmlObj){
	schema <- SDMXSchema(xmlObj);
	header <- SDMXHeader(xmlObj);
	new("SDMX",
			xmlObj = xmlObj,
			schema = schema,
			header = header); 
}


#generics
if (!isGeneric("as.XML"))
	setGeneric("as.XML", function(obj) standardGeneric("as.XML"));
	
if (!isGeneric("getSDMXSchema"))
	setGeneric("getSDMXSchema", function(obj) standardGeneric("getSDMXSchema"));
	
if (!isGeneric("getSDMXHeader"))
	setGeneric("getSDMXHeader", function(obj) standardGeneric("getSDMXHeader"));
	
if (!isGeneric("getSDMXType"))
	setGeneric("getSDMXType", function(obj) standardGeneric("getSDMXType"));

if (!isGeneric("getNamespaces"))
  setGeneric("getNamespaces", function(obj) standardGeneric("getNamespaces"));

#methods
setMethod(f = "as.XML", signature = "SDMX", function(obj){
									return(obj@xmlObj);
							}
)
setMethod(f = "getSDMXSchema", signature = "SDMX", function(obj){
									return(obj@schema);
							}
)
setMethod(f = "getSDMXHeader", signature = "SDMX", function(obj){
									return(obj@header);
							}
)
setMethod(f = "getSDMXType", signature = "SDMX", function(obj){
									return(SDMXType(obj@xmlObj));
							}
)

namespaces.SDMX <- function(xmlObj){
  nsDefs.df <-as.data.frame(
    do.call("rbind",
            lapply(xmlNamespaceDefinitions(xmlObj, simplify = F),
                   function(x){c(x$id, x$uri)})),
    stringAsFactors = FALSE
  )
  colnames(nsDefs.df) <- c("id","uri")
  nsDefs.df$id <- as.character(nsDefs.df$id)
  nsDefs.df$uri <- as.character(nsDefs.df$uri)
  return(nsDefs.df)
}

setMethod(f = "getNamespaces", signature = "SDMX", function(obj){
            return(namespaces.SDMX(obj@xmlObj));
          }
)

#others non-S4 methods
#====================

#findNamespace
findNamespace <- function(namespaces, messageType){
  regexp <- paste(messageType, "$", sep = "")
  ns <- c(ns = namespaces$uri[grep(regexp, namespaces$uri)])
  return(ns)
}
