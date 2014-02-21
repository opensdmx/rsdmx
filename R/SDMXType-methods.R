# E.Blondel - 2013/06/10
#=======================

SDMXType <- function(xmlObj){
	new("SDMXType", type = type.SDMXType(xmlObj));
}

type.SDMXType <- function(xmlObj){
	r <- xmlRoot(xmlObj); 
	type <-strsplit(xmlName(xmlRoot(xmlObj), full=T), ":")[[1]][2]
	res <- paste("SDMX", type, sep="");
	return(res)
}

#generics
if (!isGeneric("getType"))
	setGeneric("getType", function(obj) standardGeneric("getType"));

#methods
setMethod(f = "getType", signature = "SDMXType", function(obj) return(obj@type))

