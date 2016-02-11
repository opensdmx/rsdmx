#' @name SDMXStructureSpecificData
#' @rdname SDMXStructureSpecificData
#' @aliases SDMXStructureSpecificData,SDMXStructureSpecificData-method
#' 
#' @usage
#' SDMXStructureSpecificData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXStructureSpecificData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXStructureSpecificData <- function(xmlObj){
  new("SDMXStructureSpecificData",
      SDMXData(xmlObj)
  )    
}

#methods
#=======

as.data.frame.SDMXStructureSpecificData <- function(x, row.names=NULL, optional=FALSE,
                                                    labels = FALSE, ...){
  return(as.data.frame.SDMXAllCompactData(x, "structurespecific", labels));
}
