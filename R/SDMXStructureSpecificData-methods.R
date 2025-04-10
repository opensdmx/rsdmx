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
#' @export
#'
SDMXStructureSpecificData <- function(xmlObj, namespaces){
  new("SDMXStructureSpecificData",
      SDMXData(xmlObj, namespaces)
  )    
}

#methods
#=======
#'@export
as.data.frame.SDMXStructureSpecificData <- function(x, row.names=NULL, optional=FALSE,
                                                    labels = FALSE, ...){
  return(getSDMXAllCompactData(x, nsExpr = "structurespecific", labels = labels));
}
