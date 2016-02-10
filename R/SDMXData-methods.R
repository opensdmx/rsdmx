#' @name SDMXData
#' @rdname SDMXData
#' @aliases SDMXData,SDMXData-method
#' 
#' @usage
#' SDMXData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXData <- function(xmlObj){
  
  sdmxObj <- SDMX(xmlObj)
  dsdRef <- dsdRef.SDMXData(xmlObj)
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
dsdRef.SDMXData <- function(xmlObj){
  
  sdmxVersion <- version.SDMXSchema(xmlObj)
  
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


#' @name setDSD
#' @docType methods
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

if (!isGeneric("setDSD"))
  setGeneric("setDSD", function(obj,...) standardGeneric("setDSD"));

#' @describeIn setDSD
setMethod(f = "setDSD", signature = "SDMXData", function(obj, dsd){
  slot(obj, "dsd") <- dsd
  return(obj)
})
