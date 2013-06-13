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

