#' @name saveSDMX
#' @aliases saveSDMX
#' @title saveSDMX
#' @description \code{saveSDMX} is the function to save R SDMX object
#'
#' @usage saveSDMX(sdmxObj, file)
#'                 
#' @param sdmxObj an object of class \code{\link{SDMX-class}} to save
#' @param file a connection or the name of the file where the R object is saved to
#' 
#' @examples             
#'  \donttest{
#'    # Not run by 'R CMD check'
#'    # (reliable remote datasource but with possible occasional unavailability)
#'    
#'    #examples using embedded providers
#'    sdmx <- readSDMX(providerId = "OECD", resource = "data", flowRef = "MIG",
#'                      key = list("TOT", NULL, NULL), start = 2011, end = 2011)
#'    saveSDMX(sdmx, "sdmx.rda")
#'  }
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'    

saveSDMX <- function(sdmxObj, file){
  saveRDS(sdmxObj, file, refhook = XML::xmlSerializeHook)
}
