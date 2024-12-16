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
#' @export
#'
SDMXStructureSpecificTimeSeriesData <- function(xmlObj, namespaces){
  new("SDMXStructureSpecificTimeSeriesData",
      SDMXData(xmlObj, namespaces)
  )    
}

#methods
#=======
#'@export
as.data.frame.SDMXStructureSpecificTimeSeriesData <- function(x, row.names=NULL, optional=FALSE,
                                                    labels = FALSE, ...){
  return(getSDMXAllCompactData(x, nsExpr = "structurespecific", labels = labels));
}
