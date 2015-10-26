#' @name SDMXSchema
#' @rdname SDMXSchema
#' @aliases SDMXSchema,SDMXSchema-method
#' 
#' @usage
#' SDMXSchema(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXSchema"
#' 
#' @seealso \link{readSDMX}
#' 

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
	schemaVersion <-  gsub("_",".",substr(parsed[substr(parsed,0,1)=="v"],2,nchar(parsed,"w")));
	return(schemaVersion);
}
