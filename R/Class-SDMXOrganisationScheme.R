#' @name SDMXOrganisationScheme
#' @docType class
#' @aliases SDMXOrganisationScheme-class
#' 
#' @title Class "SDMXOrganisationScheme"
#' @description A basic abstract class to handle a SDMXOrganisationScheme
#'
#' @section Information:
#' This class is implemented in both SDMX 2.0 and 2.1. In the latter, it is
#' extended by other specific classes such as AgencyScheme, DataConsumerScheme,
#' DataProviderScheme and OrganisationUnitScheme. \pkg{rsdmx} covers the support
#' in SDMX 2.1
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXOrganisationScheme",
         contains = "SDMXItemScheme",
         representation(),
         prototype = list(),
         validity = function(object){  
           return(TRUE);
         }
)