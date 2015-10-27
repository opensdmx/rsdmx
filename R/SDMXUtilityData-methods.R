#' @name SDMXUtilityData
#' @rdname SDMXUtilityData
#' @aliases SDMXUtilityData,SDMXUtilityData-method
#' 
#' @usage
#' SDMXUtilityData(xmlObj)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @return an object of class "SDMXUtilityData"
#' 
#' @seealso \link{readSDMX}
#'
SDMXUtilityData <- function(xmlObj){
  new("SDMXUtilityData",
      SDMX(xmlObj)
  )  	
}

#methods
#=======

as.data.frame.SDMXUtilityData <- function(x, ...){
  return(as.data.frame.SDMXCompactData(x))
}

setAs("SDMXUtilityData", "data.frame",
      function(from) as.data.frame.SDMXUtilityData(from));
