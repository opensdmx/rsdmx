#' @name SDMXStructureSpecificData
#' @rdname SDMXStructureSpecificData
#' @aliases SDMXStructureSpecificData,SDMXStructureSpecificData-method
#' 
#' @usage
#' SDMXStructureSpecificData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXStructureSpecificData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXStructureSpecificData <- function(xmlObj, namespaces){
  new("SDMXStructureSpecificData",
      SDMXData(xmlObj, namespaces)
  )    
}

#methods
#=======

as.data.frame.SDMXStructureSpecificData <- function(x, row.names=NULL, optional=FALSE,
                                                    labels = FALSE, ...){
  return(as.data.frame.SDMXAllCompactData(x, "structurespecific", labels));
}
