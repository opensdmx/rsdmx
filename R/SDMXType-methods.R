# E.Blondel - 2013/06/10
#=======================

SDMXType <- function(xmlObj){
	new("SDMXType", type = type.SDMXType(xmlObj));
}

type.SDMXType <- function(xmlObj){
	r <- xmlRoot(xmlObj); 
	res <-xmlName(r[[2]]);
	if(res == "Structures") res <-xmlName(r[[2]][[1]])
	res <- paste("SDMX", res, sep="");
	return(res)
}

#generics
if (!isGeneric("getType"))
	setGeneric("getType", function(obj) standardGeneric("getType"));

#methods
setMethod(f = "getType", signature = "SDMXType", function(obj) return(obj@type))

