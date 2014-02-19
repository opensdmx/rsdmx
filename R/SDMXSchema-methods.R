# E.Blondel - 2013/06/09
#=======================

# constructor
SDMXSchema <- function(xmlObj) {
        new("SDMXSchema", version = version.SDMXSchema(xmlObj));
}

#default functions
version.SDMXSchema <- function(xmlObj){
	parsed <- strsplit(xmlNamespaces(xmlObj)$message$uri,"/")[[1]];
	schemaVersion <-  gsub("_",".",substr(parsed[substr(parsed,0,1)=="v"],2,nchar(parsed)));
	return(schemaVersion);
}

# define new generics
if (!isGeneric("getVersion"))
	setGeneric("getVersion", function(obj) standardGeneric("getVersion"))


# methods
setMethod("getVersion", "SDMXSchema", function(obj) obj@version);
