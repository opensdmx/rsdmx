# E.Blondel - 2013/06/09
#=======================

# constructor
SDMXSchema <- function(xmlObj) {
        new("SDMXSchema", version = version.SDMXSchema(xmlObj));
}

#default functions
version.SDMXSchema <- function(xmlObj){
	parsed <- gsub("_",".",strsplit(xmlAttrs(xmlRoot(xmlObj),FALSE,FALSE),"/")$schemaLocation);
	schemaVersion <- substr(parsed[substr(parsed,0,1)=="v"],2,nchar(parsed));
	return(schemaVersion);
}

# define new generics
if (!isGeneric("getVersion"))
	setGeneric("getVersion", function(obj) standardGeneric("getVersion"))


# methods
setMethod("getVersion", "SDMXSchema", function(obj) obj@version);
