# E.Blondel - 2014/08/21
#=======================

SDMXDataStructureDefinition <- function(xmlObj){
  new("SDMXDataStructureDefinition",
      SDMX(xmlObj),
      concepts = SDMXConcepts(xmlObj),
      codelists = SDMXCodelists(xmlObj),
      datastructures = SDMXDataStructures(xmlObj)
  )
}