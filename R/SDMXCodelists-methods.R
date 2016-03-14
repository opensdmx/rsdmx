#' @name SDMXCodelists
#' @rdname SDMXCodelists
#' @aliases SDMXCodelists,SDMXCodelists-method
#' 
#' @usage
#' SDMXCodelists(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXCodelists"
#' 
#' @seealso \link{readSDMX}
#'
SDMXCodelists <- function(xmlObj, namespaces){
  new("SDMXCodelists",
      SDMX(xmlObj, namespaces),
      codelists = codelists.SDMXCodelists(xmlObj, namespaces)
  )
}

#get list of SDMXCodelist
#=======================
codelists.SDMXCodelists <- function(xmlObj, namespaces){
  
  codelists <- NULL
  
  messageNsString <- "message"
  if(isRegistryInterfaceEnvelope(xmlObj, FALSE)) messageNsString <- "registry"
  messageNs <- findNamespace(namespaces, messageNsString)
  strNs <- findNamespace(namespaces, "structure")
  
  sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  codelistsXML <- NULL
  if(VERSION.21){
    codelistsXML <- getNodeSet(xmlObj,
                              "//mes:Structures/str:Codelists/str:Codelist",
                              namespaces = c(mes = as.character(messageNs),
                                             str = as.character(strNs)))
  }else{
    codelistsXML <- getNodeSet(xmlObj,
                              "//mes:CodeLists/str:CodeList",
                              namespaces = c(mes = as.character(messageNs),
                                             str = as.character(strNs)))
  }
  if(!is.null(codelistsXML)){
    codelists <- lapply(codelistsXML, SDMXCodelist, namespaces)
  }
  return(codelists)
}


#as.data.frame
#=============
as.data.frame.SDMXCodelists <- function(x, ...,
                                       codelistId = NULL,
                                       ignore.empty.slots = TRUE){
  xmlObj <- x@xmlObj;
  
  codes <- NULL
  if(length(x@codelists) == 0) return(codes)
  codelist <- NULL
  if(length(x@codelists) > 1){
    if(is.null(codelistId)){
      warning("Using first codelist referenced in SDMXCodelists object: \n
               Specify 'codelistId' argument for a specific codelist")
      codelist <- x@codelists[[1]]
    }else{
      selectedCodelist <- NULL
      for(i in 1:length(x@codelists)){
        cl <- x@codelists[[i]]
        if(cl@id == codelistId){
          selectedCodelist <- cl
        }
      }
      codelist <- selectedCodelist
    }
  }else{
    codelist <- x@codelists[[1]]
  }
  codesList <- codelist@Code
  
  if(!is.null(codesList)){
    codes <- do.call("rbind.fill",
                        lapply(codesList, function(code){
                          as.data.frame(sapply(slotNames(code), function(x){
                            obj <- slot(code,x)
                            return(obj)
                          }), stringsAsFactors = FALSE)
                        })
    )
  }
  
  if(ignore.empty.slots){
    codes <- codes[,colSums(is.na(codes))<nrow(codes)]
  }
  
  return(encodeSDMXOutput(codes))
}

setAs("SDMXCodelists", "data.frame",
      function(from) as.data.frame.SDMXCodelists(from));
