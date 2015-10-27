#' @name SDMXServiceProvider
#' @docType class
#' @aliases SDMXServiceProvider-class
#' 
#' @title Class "SDMXServiceProvider"
#' @description A basic class to handle a SDMX service provider
#' 
#' @slot agencyId an object of class "character" giving the a provider identifier
#' @slot name an object of class "character" giving the name of the provider
#' @slot scale an object of class "character" giving the scale of the datasource, 
#'       either "international" or "national"
#' @slot country an object of class "character" giving the ISO 3-alpha code of 
#'       the country (if scale is "national")
#' @slot builder an object of class "SDMXRequestBuilder" that will performs the 
#'       web request building
#'          
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXServiceProvider",
         representation(
           agencyId = "character",
           name = "character",
           scale = "character",
           country = "character",
           builder = "SDMXRequestBuilder"
         ),
         prototype = list(
           agencyId = "MYORG",
           name = "My Organization",
           scale = "international",
           country = as.character(NA),
           footer = new("SDMXRequestBuilder")
         ),
         validity = function(object){
           return(TRUE);
         }
)
