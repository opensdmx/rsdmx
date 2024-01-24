#' @name SDMXConcepts
#' @rdname SDMXConcepts
#' @aliases SDMXConcepts,SDMXConcepts-method
#' 
#' @usage
#' SDMXConcepts(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXConcepts"
#' 
#' @seealso \link{readSDMX}
#'
SDMXConcepts <- function(xmlObj, namespaces){
  new("SDMXConcepts",
      SDMX(xmlObj, namespaces),
      concepts = concepts.SDMXConcepts(xmlObj, namespaces),
      conceptSchemes = conceptSchemes.SDMXConcepts(xmlObj, namespaces)
  )
}

#get list of SDMXConcept (backward compatibility with SDMX 1.0)
#=======================
concepts.SDMXConcepts <- function(xmlObj, namespaces){
  
  concepts <- NULL

  messageNsString <- "message"
  if(isRegistryInterfaceEnvelope(xmlObj, FALSE)) messageNsString <- "registry"
  messageNs <- findNamespace(namespaces, messageNsString)
  strNs <- findNamespace(namespaces, "structure")
  
  sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
  VERSION.21 <- sdmxVersion == "2.1"
  
  conceptsXML <- NULL
  if(VERSION.21){
    conceptsXML <- getNodeSet(xmlObj,
                              "//mes:Structures/str:Concepts/str:Concept",
                              namespaces = c(mes = as.character(messageNs),
                                             str = as.character(strNs)))
  }else{
    conceptsXML <- getNodeSet(xmlObj,
                              "//mes:Concepts/str:Concept",
                              namespaces = c(mes = as.character(messageNs),
                                             str = as.character(strNs)))
  }
  if(!is.null(conceptsXML)){
    concepts <- lapply(conceptsXML, SDMXConcept, namespaces)
  }
  return(concepts)
}

#get list of SDMXConceptScheme (from SDMX 2.0)
#=============================
conceptSchemes.SDMXConcepts <- function(xmlObj, namespaces){
  
  conceptSchemes <- NULL 
  strNs <- findNamespace(namespaces, "structure") 
  conceptSchemesXML <- getNodeSet(xmlObj,
                                  "//ns:ConceptScheme",
                                  namespaces = strNs)
  conceptSchemes <- lapply(conceptSchemesXML, SDMXConceptScheme, namespaces)
  
  return(conceptSchemes)
}

#as.data.frame
#=============
as.data.frame.SDMXConcepts <- function(x, ...,
                                       conceptSchemeId = NULL,
                                       ignore.empty.slots = TRUE){
  xmlObj <- x@xmlObj;
  
  concepts <- NULL
  conceptsList <- NULL
  if(length(x@concepts) > 0){
    conceptsList <- x@concepts
    
  }else if(length(x@conceptSchemes) > 0){
    if(is.null(conceptSchemeId) & length(x@conceptSchemes) > 0){
      warning("Using first conceptScheme referenced in SDMXConcepts object: \n
               Specify 'conceptSchemeId' argument for a specific conceptScheme")
      conceptScheme <- x@conceptSchemes[[1]]
    }else{
      conceptScheme <- NULL
      for(i in 1:length(x@conceptSchemes)){
        cs <- x@conceptSchemes[[i]]
        if(cs@id == conceptSchemeId) conceptScheme <- cs
      }
    }    
    conceptsList <- conceptScheme@Concept 
  }
  
  if(!is.null(conceptsList)){
    concepts <- do.call("rbind.fill",
     lapply(conceptsList, function(concept){
       as.data.frame(sapply(slotNames(concept), function(x){
         obj <- slot(concept,x)
         if(all(is.na(obj))){
           obj <- switch(class(obj),
                     "character" = NA,
                     "logical" = NA,
                     "list" = structure(as.list(rep(NA,length(concept@Name))),
                                        .Names = names(concept@Name))
           )
         }
         return(obj)
       }))
     })
    )
  }
  
  if(ignore.empty.slots){
    concepts <- concepts[,colSums(is.na(concepts))<nrow(concepts)]
  }
  
  return(encodeSDMXOutput(concepts))
}

setAs("SDMXConcepts", "data.frame",
      function(from) as.data.frame.SDMXConcepts(from));