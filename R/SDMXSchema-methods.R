#' @name SDMXSchema
#' @rdname SDMXSchema
#' @aliases SDMXSchema,SDMXSchema-method
#' 
#' @usage
#' SDMXSchema(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXSchema"
#' 
#' @seealso \link{readSDMX}
#' 

SDMXSchema <- function(xmlObj, namespaces) {
        new("SDMXSchema", version = version.SDMXSchema(xmlObj, namespaces));
}

#default functions
version.SDMXSchema <- function(xmlObj, namespaces){
	schemaVersion <- NULL
  for(i in 1:nrow(namespaces)){
    parsed <- strsplit(namespaces$uri[i],"/")[[1]];
    if(tolower(parsed[3]) == "www.sdmx.org"){
	    schemaVersion <-  gsub("_",".",substr(parsed[substr(parsed,0,1)=="v"],2,nchar(parsed,"w")));
      break;
    }
  }
	return(schemaVersion);
}
