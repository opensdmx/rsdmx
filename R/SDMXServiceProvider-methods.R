#' @name SDMXServiceProvider
#' @rdname SDMXServiceProvider
#' @aliases SDMXServiceProvider,SDMXServiceProvider-method
#' 
#' @usage
#' SDMXServiceProvider(agencyId, name, scale, country, builder)
#' 
#' @param agencyId an object of class "character" giving the a provider identifier
#' @param name an object of class "character" giving the name of the provider
#' @param scale an object of class "character" giving the scale of the datasource, 
#'        either "international" or "national". Default value is "international".
#' @param country an object of class "character" giving the ISO 3-alpha code of 
#'        the country (if scale is "national"). Default value is \code{NA}
#' @param builder an object of class "SDMXRequestBuilder" that will performs the 
#'        web request building for this specific provider
#' @return an object of class "SDMXServiceProvider"
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
#' @examples
#'   #let's create a SDMXRESTRequestBuilder
#'   #(assuming that "My Organization" implements SDMX REST web-services)
#'   myBuilder <- SDMXRESTRequestBuilder(regUrl = "http://www.myorg.org/registry",
#'                                       repoUrl = "http://www.myorg.org/repository",
#'                                       compliant = TRUE)
#'   
#'   #create a SDMXServiceProvider
#'   provider <- SDMXServiceProvider(agencyId = "MYORG", name = "My Organization",
#'                                   builder = myBuilder)
#'                                   
SDMXServiceProvider <- function(agencyId, name,
                                scale = "international", country = as.character(NA),
                                builder) {
  new("SDMXServiceProvider",
      agencyId = agencyId,
      name = name,
      scale = scale,
      country = country,
      builder = builder);
}

#other non-S4 methods
#====================

#' @name setSDMXServiceProviders
#' @aliases setSDMXServiceProviders
#' @title setSDMXServiceProviders
#'
#' @description function used internally by \pkg{rsdmx}, when loading the package, 
#'              to set the list of \link{SDMXServiceProvider} known by \pkg{rsdmx} 
#'              (hence known by \link{readSDMX} to query data/metadata in an easier 
#'              way). For internal use only (this function does not provide any 
#'              value for the end user, but it is here documented for transparency, 
#'              and to explain how the package works.)
#'              
#' @usage
#' setSDMXServiceProviders()
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
#' @seealso \link{getSDMXServiceProviders} \link{addSDMXServiceProvider}
#'          \link{findSDMXServiceProvider} \link{readSDMX}
#'
setSDMXServiceProviders <- function(){ # nocov start
  
  listOfProviders <- list(
    
      #international data providers
      #----------------------------
    
      #ECB
      SDMXServiceProvider(
        agencyId = "ECB", name = "European Central Bank",
        builder = SDMXRESTRequestBuilder(
          regUrl = "https://sdw-wsrest.ecb.europa.eu/service",
          repoUrl = "https://sdw-wsrest.ecb.europa.eu/service",
          compliant = TRUE)
      ),
    
      #EUROSTAT
      SDMXServiceProvider( 
        agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union)",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://ec.europa.eu/eurostat/SDMX/diss-web/rest",
          repoUrl = "http://ec.europa.eu/eurostat/SDMX/diss-web/rest",
          compliant = TRUE)
      ),
    
      #OECD
      SDMXServiceProvider(
        agencyId = "OECD", name = "Organisation for Economic Cooperation and Development ",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://stats.oecd.org/restsdmx/sdmx.ashx",
          repoUrl = "http://stats.oecd.org/restsdmx/sdmx.ashx",
          compliant = FALSE)
      ),
      
      #UN-FAO
      SDMXServiceProvider(
        agencyId = "FAO", name = "Food and Agriculture Organization of the United Nations",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://data.fao.org/sdmx/registry",
          repoUrl = "http://data.fao.org/sdmx/repository",
          compliant = TRUE,
          unsupportedResources = list("dataflow"))
      ),
      
      #UN-ILO
      SDMXServiceProvider(
        agencyId = "ILO", name = "International Labour Organization of the United Nations",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
          repoUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
          compliant = TRUE, skipAgencyId = TRUE,
          unsupportedResources = list("dataflow"))                  
      ),
      
      #UIS (UNESCO)
      SDMXServiceProvider(
        agencyId = "UIS", name = "UNESCO Institute of Statistics",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://data.uis.unesco.org/RestSDMX/sdmx.ashx",
          repoUrl = "http://data.uis.unesco.org/RestSDMX/sdmx.ashx", 
          compliant = TRUE,
          unsupportedResources = list("dataflow"))
      ),
      
      #national data providers
      #-----------------------
      
      #ABS {Australia}
      SDMXServiceProvider(
        agencyId = "ABS", name = "Australian Bureau of Statistics",
        scale = "national", country = "AUS",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://stat.abs.gov.au/restsdmx/sdmx.ashx",
          repoUrl = "http://stat.abs.gov.au/restsdmx/sdmx.ashx", 
          compliant = FALSE, forceAgencyId = TRUE,
          unsupportedResources = list("dataflow"))
      ),
      
      #NBB {Belgium}
      SDMXServiceProvider(
        agencyId = "NBB", name = "National Bank of Belgium",
        scale = "national", country = "BEL",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://stat.nbb.be/RestSDMX/sdmx.ashx",
          repoUrl = "http://stat.nbb.be/RestSDMX/sdmx.ashx", 
          compliant = FALSE,
          unsupportedResources = list("dataflow"))
      ),
      
      #INSEE {France}
      SDMXServiceProvider(
        agencyId = "INSEE", name = "Institut national de la statistique et des \u00e9tudes \u00e9conomiques",
        scale = "national", country = "FRA",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://www.bdm.insee.fr/series/sdmx",
          repoUrl = "http://www.bdm.insee.fr/series/sdmx", 
          compliant = TRUE)
      )
      
  )
  
  .rsdmx.options$providers <- new("SDMXServiceProviders", providers = listOfProviders)
  
} # nocov end


#' @name addSDMXServiceProvider
#' @aliases addSDMXServiceProvider
#' @title addSDMXServiceProvider
#' @description function that allows configuring a new \link{SDMXServiceProvider} 
#'              as part of the list of providers known by \pkg{rsdmx}, hence by 
#'              \link{readSDMX}
#'              
#' @usage
#' addSDMXServiceProvider(provider)
#' 
#' @param provider an object of class "SDMXServiceProvider"
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
#' @examples
#'   #create a provider
#'   myBuilder <- SDMXRESTRequestBuilder(regUrl = "http://www.myorg.org/registry",
#'                                       repoUrl = "http://www.myorg.org/repository",
#'                                       compliant = TRUE)
#'   myProvider <- SDMXServiceProvider(
#'     agencyId = "MYORG", name = "My Organization",
#'     builder = myBuilder
#'   )
#'   
#'   #add it
#'   addSDMXServiceProvider(myProvider)
#'   
#'   #check out the list of existing provider (only list the agency Ids)
#'   sapply(slot(getSDMXServiceProviders(), "providers"), function(x){slot(x, "agencyId")})
#'   
#' @seealso \link{getSDMXServiceProviders} \link{findSDMXServiceProvider}
#'          \link{readSDMX}
#'          
addSDMXServiceProvider <- function(provider){
  .rsdmx.options$providers <- new("SDMXServiceProviders",
                                  providers = c(slot(.rsdmx.options$providers, "providers"), provider)
                              )
}


#' @name getSDMXServiceProviders
#' @aliases getSDMXServiceProviders
#' @title getSDMXServiceProviders
#' @description function used to get the list of \link{SDMXServiceProvider} known
#'              by \pkg{rsdmx} (hence known by \link{readSDMX} to query data or 
#'              metadata in an easier way). This function can be easily used to 
#'              interrogate the list of known providers, and eventually consider 
#'              adding one at runtime with \link{addSDMXServiceProvider}
#' @usage
#' getSDMXServiceProviders()
#' 
#' @return an object of class "list" (of \link{SDMXServiceProvider})
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
#' @seealso \link{addSDMXServiceProvider} \link{findSDMXServiceProvider}
#'          \link{readSDMX}
#'          
getSDMXServiceProviders <- function(){
  out <- .rsdmx.options$providers
  return(out)
}


#' @name findSDMXServiceProvider
#' @aliases findSDMXServiceProvider
#' @title findSDMXServiceProvider
#' 
#' @description function that allows searching by provider id in the list of 
#'              known \link{SDMXServiceProvider}. This function can be used for 
#'              interrogating the list of default providers known by \pkg{rsdmx}, 
#'              and is used internally by \link{readSDMX}
#' @usage
#' findSDMXServiceProvider(agencyId)
#' 
#' @param agencyId an object of class "character" representing a provider 
#'        identifier
#' @return an object of class "SDMXServiceProvider" (or NULL if no matching)
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
#' @examples
#'   #find OECD provider
#'   oecd.provider <- findSDMXServiceProvider("OECD")
#'   
#' @seealso \link{getSDMXServiceProviders} \link{addSDMXServiceProvider}
#'          \link{readSDMX}
#'
findSDMXServiceProvider <- function(agencyId){
  res <- unlist(lapply(slot(getSDMXServiceProviders(),"providers"),
                       function(x) {if(x@agencyId == agencyId){return(x)}}))
  if(!is.null(res) && length(res) > 0) res <- res[[1]]
  return(res)
}
