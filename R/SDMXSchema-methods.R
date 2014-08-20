# E.Blondel - 2013/06/09
#=======================

# constructor
SDMXSchema <- function(xmlObj) {
        new("SDMXSchema", version = version.SDMXSchema(xmlObj));
}

#default functions
version.SDMXSchema <- function(xmlObj){
  nsDefs.df <- namespaces.SDMX(xmlObj)
  ns.df <- nsDefs.df[
    regexpr("http://www.sdmx.org", nsDefs.df$uri,
            "match.length", ignore.case = TRUE) == 1
    & regexpr("http://www.w3.org", nsDefs.df$uri,
              "match.length", ignore.case = TRUE) == -1,]
	parsed <- strsplit(ns.df[1,]$uri,"/")[[1]];
	schemaVersion <-  gsub("_",".",substr(parsed[substr(parsed,0,1)=="v"],2,nchar(parsed)));
	return(schemaVersion);
}

# define new generics
if (!isGeneric("getVersion"))
	setGeneric("getVersion", function(obj) standardGeneric("getVersion"))


# methods
setMethod("getVersion", "SDMXSchema", function(obj) obj@version);
