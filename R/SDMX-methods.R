#' @name SDMX
#' @rdname SDMX
#' @aliases SDMX,SDMX-method
#' 
#' @usage
#' SDMX(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMX"
#' 
#' @seealso \link{readSDMX}

SDMX <- function(xmlObj, namespaces){
	schema <- SDMXSchema(xmlObj, namespaces);
	header <- SDMXHeader(xmlObj, namespaces);
  footer <- SDMXFooter(xmlObj, namespaces);
	new("SDMX",
			xmlObj = xmlObj,
			schema = schema,
			header = header,
      footer = footer); 
}

#functions
namespaces.SDMX <- function(xmlObj){
  nsFromXML <- xmlNamespaceDefinitions(xmlObj, addNames = FALSE,
                                       recursive = TRUE, simplify = FALSE)
  nsDefs.df <- do.call("rbind",
                       lapply(nsFromXML,
                              function(x){
                                out <- NULL
                                if(length(names(x)) > 0) out <- x$uri
                                return(out)
                              }))
  row.names(nsDefs.df) <- 1:nrow(nsDefs.df)
  nsDefs.df <- as.data.frame(nsDefs.df, stringsAsFactors = FALSE)
  if(nrow(nsDefs.df) > 0){
    colnames(nsDefs.df) <- "uri"
    nsDefs.df$uri <- as.character(nsDefs.df$uri)
    nsDefs.df <- unique(nsDefs.df)
    
    nsDefs.df <- nsDefs.df[!duplicated(nsDefs.df$uri),]
    nsDefs.df <- as.data.frame(nsDefs.df, stringsAsFactors = FALSE)
    colnames(nsDefs.df) <- "uri"
    
    nsDefs.df <- nsDefs.df[
        regexpr("http://www.w3.org", nsDefs.df$uri,
                "match.length", ignore.case = TRUE) == -1,]
    nsDefs.df <- as.data.frame(nsDefs.df, stringsAsFactors = FALSE)
    colnames(nsDefs.df) <- "uri"
  }
  
  return(nsDefs.df)
}

encodeSDMXOutput <- function(df){
  for(col in colnames(df)){
    if(is(df[,col],"character")) Encoding(df[,col]) <- "UTF-8"
  }
  return(df)
}


#' @name getNamespaces
#' @docType methods
#' @aliases getNamespaces,SDMX-method
#' @title getNamespaces
#' @description Access the namespaces of the SDMX-ML object
#' @usage getNamespaces(obj)
#' 
#' @param obj An object deriving from class "SDMX"
#' @return an object of class \code{data.frame} giving the id and uri for each 
#'         of the namespaces handled in the SDMX-ML document.
#'
#' @seealso \link{SDMX-class}
#'
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}

if (!isGeneric("getNamespaces"))
  setGeneric("getNamespaces", function(obj) standardGeneric("getNamespaces"));

#' @describeIn getNamespaces Access the namespaces of the SDMX-ML object
setMethod(f = "getNamespaces", signature = "SDMX", function(obj){
            return(namespaces.SDMX(obj@xmlObj));
          })

#others non-S4 methods
#====================

#' @name findNamespace
#' @aliases findNamespace
#' @title findNamespace
#' @description function used to find a specific namespace within the available 
#'              namespaces of an SDMX-ML object
#'
#' @usage
#' findNamespace(namespaces, messageType)
#' 
#' @param namespaces object of class \code{data.frame} giving the namespaces URIs
#'        available in a SDMX-ML object, typically obtained with \link{getNamespaces}
#' @param messageType object of class \code{character} representing a message type
#' @return an object of class "character" giving the namespace uri if found in the
#'         available namespaces
#'         
#' @section Warning:
#' \code{findNamespace} is a function used internally as utility function in 
#' SDMX-ML object parsers.
#' 
#' @seealso \link{SDMX-class} \link{getNamespaces} 
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}

findNamespace <- function(namespaces, messageType){
  regexp <- paste(messageType, "$", sep = "")
  ns <- c(ns = namespaces$uri[grep(regexp, namespaces$uri, ignore.case = TRUE)])
  return(ns)
}


#' @name isSoapRequestEnvelope
#' @aliases isSoapRequestEnvelope
#' @title isSoapRequestEnvelope
#' @description function used to detect if the XML document corresponds to a SOAP
#'              request response
#' @usage
#' isSoapRequestEnvelope(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "logical"
#' 
#' @section Warning:
#' \code{isSoapRequestEnvelope} is a function used internally by \link{readSDMX}
#' 
#' @seealso \link{SDMX-class} \link{readSDMX}
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 

isSoapRequestEnvelope <- function(xmlObj, namespaces){
  return(tolower(xmlName(xmlRoot(xmlObj))) == "envelope")
}

#' @name getSoapRequestResult
#' @aliases getSoapRequestResult
#' @title getSoapRequestResult
#' @description function used to extract the SDMX-ML message from a SOAP request 
#'              response
#' @usage
#' getSoapRequestResult(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "XMLInternalDocument derived from XML package
#' 
#' @section Warning:
#' \code{getSoapRequestResult} is a function used internally by \link{readSDMX}
#' 
#' @seealso \link{SDMX-class} \link{readSDMX}
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
   
getSoapRequestResult <- function(xmlObj){
  body <- xmlChildren(xmlRoot(xmlObj))
  response <- xmlChildren(body[[1]]); rm(body);
  result <- xmlChildren(response[[1]]); rm(response);
  sdmxDoc <- xmlDoc(xmlChildren(result[[1]])[[1]]); rm(result);
  return(sdmxDoc)
}


#' @name isRegistryInterfaceEnvelope
#' @aliases isRegistryInterfaceEnvelope
#' @title isRegistryInterfaceEnvelope
#' @description function used to detect if the XML document corresponds to a 
#'              registry interface query
#' @usage
#' isRegistryInterfaceEnvelope(xmlObj, nativeRoot)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param nativeRoot object of class "logical" indicating if it is the native document
#' @return an object of class "logical"
#' 
#' @section Warning:
#' \code{isRegistryInterfaceEnvelope} is a function used internally by \link{readSDMX}
#' 
#' @seealso \link{SDMX-class} \link{readSDMX}
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 

isRegistryInterfaceEnvelope <- function(xmlObj, nativeRoot){
  root <- xmlRoot(xmlObj)
  if(nativeRoot) root <- root[[1]]
  return(xmlName(root) == "RegistryInterface")
}

#' @name getRegistryInterfaceResult
#' @aliases getRegistryInterfaceResult
#' @title getRegistryInterfaceResult
#' @description function used to extract the SDMX-ML message from a registry
#'              interface query
#' @usage
#' getRegistryInterfaceResult(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "XMLInternalDocument derived from XML package
#' 
#' @section Warning:
#' \code{getRegistryInterfaceResult} is a function used internally by \link{readSDMX}
#' 
#' @seealso \link{SDMX-class} \link{readSDMX}
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}

getRegistryInterfaceResult <- function(xmlObj){
  sdmxDoc <- xmlDoc(xmlChildren(xmlRoot(xmlObj))[[1]])
  return(sdmxDoc)
}