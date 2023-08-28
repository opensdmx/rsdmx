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
#'    sdmx <- system.file("extdata","Example_Eurostat_2.0.xml", package="rsdmx")
#'    saveSDMX(sdmx, "sdmx.rda")
#'  }
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'    

saveSDMX <- function(sdmxObj, file){
  saveRDS(sdmxObj, file, refhook = XML::xmlSerializeHook)
}
