#' @name SDMXData
#' @rdname SDMXData
#' @aliases SDMXData,SDMXData-method
#' 
#' @usage
#' SDMXData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' 
#' @return an object of class "SDMXData"
#' 
#' @seealso \link{readSDMX}
#' @export
#' 
SDMXData <- function(xmlObj, namespaces){
  
  sdmxObj <- SDMX(xmlObj, namespaces)
  dsdRef <- dsdRef.SDMXData(xmlObj, namespaces)
  dsd <- NULL
  if(!is.null(dsdRef)){
    dsd <- NULL
  }
  
  new("SDMXData",
      sdmxObj,
      dsdRef = dsdRef,
      dsd = dsd
  )  	
}

#get DSD REF
#===========
dsdRef.SDMXData <- function(xmlObj, namespaces){
  
  sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
  
  dsXML <- xmlChildren(xmlChildren(xmlObj)[[1]])$DataSet
  dsdRef <- switch(sdmxVersion,
    "1.0" = NULL, #TODO
    "2.0" = {
      ref <- NULL
      xml <- xmlChildren(dsXML)
      xmlNames <- names(xml)
      if("KeyFamilyRef" %in% xmlNames){
        keyFamilyRef <- xml$KeyFamilyRef
        ref <- xmlValue(keyFamilyRef)
      }
      ref
    },
    "2.1" = xmlGetAttr(dsXML,"structureRef")
  )
  return(dsdRef)
}

#ENRICH DATA WITH LABELS
#=======================
addLabels.SDMXData <- function(data, dsd){
  
  #try to inherit datastructure components
  components <- NULL
  datastructures <- slot(slot(dsd,"datastructures"), "datastructures")
  if(length(datastructures)>0){
    ds <- datastructures[[1]]
    components <- slot(ds, "Components")
    components <- as.data.frame(components)
  }
    
  #function to enrich a column with its labels
  enrichColumnWithLabels <- function(column, data, dsd, components){
    datac <- as.data.frame(data[,column], stringsAsFactors = FALSE)
    colnames(datac) <- column
    
    #grab codelist name
    clName <- NULL
    if(!is.null(components)){
      #try to grab codelist using concepts
      clMatcher <- components$conceptRef == column
      clName <- components[clMatcher, "codelist"]
      if(is.null(clName) || all(is.na(clName))){
        #try to grab codelist using regexpr on codelist
        clMatcher <- regexpr(column, components$codelist, ignore.case = TRUE)
        attr(clMatcher,"match.length")[is.na(clMatcher)] <- -1
        clName <- components[attr(clMatcher,"match.length")>1, "codelist"]
        if(length(clName)>1) clName <- clName[1]
      }
      
      if(length(clName)>0 && !is.na(clName)){
        #additional check in case codelist would not be specified in DSD
        codelists <- sapply(slot(slot(dsd,"codelists"), "codelists"), slot, "id")
        if(!(clName %in% codelists)){
          clName <- NULL
        }
      }

    }else{
      #no components, take the column name as codelistId
      codelists <- sapply(slot(slot(dsd,"codelists"), "codelists"), slot, "id")
      if(column %in% codelists){
        clName <- column
      }
    }
    
    if(length(clName) != 0 && !is.na(clName) && !is.null(clName)){
      cl <- as.data.frame(slot(dsd, "codelists"), codelistId = clName)
      datac$order <- seq(len=nrow(datac))
      datac = merge(x = datac, y = cl, by.x = column, by.y = "id",
                    all.x = TRUE, all.y = FALSE, sort = FALSE)
      datac <- datac[sort.list(datac$order),]
      datac$order <- NULL
      datac <- datac[,((regexpr("label", colnames(datac)) != -1) + 
                         (colnames(datac) == column) == 1)]
      colnames(datac)[regexpr("label",colnames(datac)) != -1] <- paste0(column,
      "_",colnames(datac)[regexpr("label",colnames(datac)) != -1])
    }

    return(datac)  
  }
  
  fulldata <- do.call("cbind" ,lapply(colnames(data), enrichColumnWithLabels,
                                      data, dsd, components))
  return(fulldata)
}


#' @name setDSD
#' @docType methods
#' @rdname SDMXData-method
#' @aliases setDSD,SDMXData-method
#' @title setDSD
#' @description set the 'dsd' slot of a \code{SDMXData} object
#' @usage setDSD(obj, dsd)
#' 
#' @param obj An object deriving from class "SDMXData"
#' @param dsd An object of class "SDMXDataStructureDefinition"
#' @return the 'obj' object of class "SDMXData" enriched with the dsd
#'
#' @seealso \link{SDMXData-class}
#'
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
setGeneric("setDSD", function(obj, dsd) standardGeneric("setDSD"));

#' @rdname SDMX-methods
#' @aliases setDSD,SDMXData,SDMXDataStructureDefinition-method
setMethod(f = "setDSD", signature = c("SDMXData", "SDMXDataStructureDefinition"), function(obj, dsd){
  slot(obj, "dsd") <- dsd
  return(obj)
})
