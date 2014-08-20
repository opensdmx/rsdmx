# E.Blondel - 2014/08/20
#=======================

SDMXCodelists <- function(xmlObj){
  new("SDMXCodelists",
      SDMX(xmlObj),
      codelists = codelists.SDMXCodelists(xmlObj)
  )
}

#get list of SDMXCodelist
#=======================
codelists.SDMXCodelists <- function(xmlObj){
  
  codelists <- NULL
  
  sdmxVersion <- version.SDMXSchema(xmlObj)
  VERSION.21 <- sdmxVersion == "2.1"
  
  namespaces <- namespaces.SDMX(xmlObj)
  messageNs <- findNamespace(namespaces, "message")
  strNs <- findNamespace(namespaces, "structure")
  
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
    codelists <- lapply(codelistsXML, function(x){ SDMXCodelist(x)})
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
      sapply(x@codelists, function(cl){
        if(cl@id == codelistId) codelist <- cl
      })
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
                          }))
                        })
    )
  }
  
  if(ignore.empty.slots){
    codes <- codes[,colSums(is.na(codes))<nrow(codes)]
  }
  
  return(codes)
}

setAs("SDMXCodelists", "data.frame",
      function(from) as.data.frame.SDMXCodelists(from));
