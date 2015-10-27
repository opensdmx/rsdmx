#' @name SDMXPrimaryMeasure
#' @docType class
#' @aliases SDMXPrimaryMeasure-class
#'
#' @title Class "SDMXPrimaryMeasure
#' @description A basic class to handle a SDMX PrimaryMeasure
#'
#' @slot conceptRef Object of class "character" giving the dimension conceptRef (required)
#' @slot conceptVersion Object of class "character" giving the dimension concept version
#' @slot conceptAgency Object of class "character" giving the dimension concept agency
#' @slot conceptSchemeRef Object of class "character" giving the dimension conceptScheme ref
#' @slot conceptSchemeAgency Object of class "character" giving the dimension conceptScheme agency
#' @slot codelist Object of class "character" giving the codelist ref name
#' @slot codelistVersion Object of class "character" giving the codelist ref version
#' @slot codelistAgency Object of class "character" giving the codelist ref agency
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document.
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXPrimaryMeasure",
         representation(
           #attributes
           conceptRef = "character", #required
           conceptVersion = "character", #optional
           conceptAgency = "character", #optional
           conceptSchemeRef = "character", #optional
           conceptSchemeAgency = "character", #optional
           codelist = "character", #optional
           codelistVersion = "character", #optional
           codelistAgency = "character" #optional
           
           #elements
           #TextFormat = "SDMXTextFormat" #optional
         ),
         prototype = list(
           #attributes
           conceptRef = "CONCEPT",
           conceptVersion = "1.0",
           conceptAgency = "ORG",
           conceptSchemeRef = "CONCEPT_SCHEME",
           conceptSchemeAgency = "ORG",
           codelist = "CODELIST",
           codelistVersion = "1.0",
           codelistAgency = "ORG"
           
           #elements
           #TextFormat = new("SDMXTextFormat")
         ),
         validity = function(object){
           
           #eventual validation rules
           if(is.na(object@conceptRef)) return(FALSE)
           return(TRUE);
         }
)
