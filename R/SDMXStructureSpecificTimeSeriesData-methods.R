#' @name SDMXStructureSpecificTimeSeriesData
#' @rdname SDMXStructureSpecificTimeSeriesData
#' @aliases SDMXStructureSpecificTimeSeriesData,SDMXStructureSpecificTimeSeriesData-method
#' 
#' @usage
#' SDMXStructureSpecificTimeSeriesData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXStructureSpecificTimeSeriesData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXStructureSpecificTimeSeriesData <- function(xmlObj, namespaces){
  new("SDMXStructureSpecificTimeSeriesData",
      SDMXData(xmlObj, namespaces)
  )    
}

#methods
#=======

as.data.frame.SDMXStructureSpecificTimeSeriesData <- function(x, row.names=NULL, optional=FALSE,
                                                    labels = FALSE, ...){
  return(as.data.frame.SDMXAllCompactData(x, "structurespecific", labels));
}
