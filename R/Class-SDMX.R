#' @name SDMX
#' @rdname SDMX
#' @docType class
#' @aliases SDMX-class
#' 
#' @title Class "SDMX"
#' @description An abstract class from which SDMX classes are derived
#'
#' @slot xmlObj Object of class "XMLInternalDocument" derived from XML package  
#' @slot schema Object of class "SDMXSchema", handles the version of SDMX-ML format
#' @slot header Object of class "SDMXHeader", handles the SDMX-ML document header
#' @slot footer Object of class "SDMXFooter", handles the SDMX-ML document footer
#'  
#' @section Warning:
#' This class is not useful in itself, but all SDMX classes in this package derive
#' from it.                  
#'  
#' @note
#'  Currently, the approach drafted in \link{rsdmx} package was to rely on XML
#'  package, read the xml object and store it as part of the SDMX R object. Another
#'  approach being investigated is to use XML handlers throughthe Simple API for XML
#'  (SAX) that could avoid to load the full XML tree in the SDMX R object (xmlObj). 
#'  Indeed, SDMX data could be huge and causes issues of memory if the complete XML
#'  tree is loaded in the R user session.
#'  
#'  @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'                  

setClass("SDMX",
	representation(
		xmlObj = "XMLInternalDocument",
		schema = "SDMXSchema",
		header = "SDMXHeader",
		footer = "SDMXFooter"
	),
	prototype = list(
      		xmlObj = NULL,
      		schema = new("SDMXSchema"),
      		header = new("SDMXHeader"),
      		footer = new("SDMXFooter")
      	),
	validity = function(object){
		return(TRUE);
	}
)

#class unions for base data types
setClassUnion("character_OR_NULL", c("character", "NULL"))
setClassUnion("character_OR_numeric_OR_NULL", c("character", "numeric", "NULL"))
