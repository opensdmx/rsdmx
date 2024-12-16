#' @name SDMXUtilityData
#' @rdname SDMXUtilityData
#' @aliases SDMXUtilityData,SDMXUtilityData-method
#' 
#' @usage
#' SDMXUtilityData(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXUtilityData"
#' 
#' @seealso \link{readSDMX}
#' @export
#'
SDMXUtilityData <- function(xmlObj, namespaces){
  new("SDMXUtilityData",
      SDMXData(xmlObj, namespaces)
  )  	
}

#methods
#=======
#'@export
as.data.frame.SDMXUtilityData <- function(x, row.names=NULL, optional=FALSE,
                                          labels = FALSE, ...){
  return(as.data.frame.SDMXCompactData(x, labels))
}
