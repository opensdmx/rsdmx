#' @name SDMXDataStructureDefinition
#' @rdname SDMXDataStructureDefinition
#' @aliases SDMXDataStructureDefinition,SDMXDataStructureDefinition-method
#' 
#' @usage
#' SDMXDataStructureDefinition(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXDataStructureDefinition"
#' 
#' @seealso \link{readSDMX}
#'
SDMXDataStructureDefinition <- function(xmlObj){
  new("SDMXDataStructureDefinition",
      SDMX(xmlObj),
      concepts = SDMXConcepts(xmlObj),
      codelists = SDMXCodelists(xmlObj),
      datastructures = SDMXDataStructures(xmlObj)
  )
}