# E.Blondel - 2015/09/22
#========================

#constructor
SDMXServiceProvider <- function(agencyId, name, builder) {
  new("SDMXServiceProvider", agencyId = agencyId, name = name, builder = builder);
}

#other non-S4 methods
#====================

#function to set a well-known list of SDMX service providers
setSDMXServiceProviders <- function(){
  
  listOfProviders <- list(
    
      #ECB
      SDMXServiceProvider(
        "ECB", "European Central Bank",
        SDMXRESTRequestBuilder("https://sdw-wsrest.ecb.europa.eu/service", TRUE)
      ),
    
      #EUROSTAT
      SDMXServiceProvider(
        "ESTAT", "Eurostat (Statistical office of the European Union)",
        SDMXRESTRequestBuilder("http://ec.europa.eu/eurostat/SDMX/diss-web/rest", TRUE)
      ),
    
      #OECD
      SDMXServiceProvider(
        "OECD", "Organisation for Economic Cooperation and Development ",
        SDMXRESTRequestBuilder("http://stats.oecd.org/restsdmx/sdmx.ashx", TRUE)
      ),
      
      #UN-FAO
      SDMXServiceProvider(
        "FAO", "Food and Agriculture Organization of the United Nations",
        SDMXRESTRequestBuilder("http://data.fao.org/sdmx/repository", TRUE)
      ),
      
      #UN-ILO
      SDMXServiceProvider(
        "ILO", "International Labour Organization of the United Nations",
        SDMXRESTRequestBuilder("http://www.ilo.org/ilostat/sdmx/ws/rest", FALSE)                  
      ),
      
      #UIS (UNESCO)
      SDMXServiceProvider(
        "UIS", "UNESCO Institute of Statistics",
        SDMXRESTRequestBuilder("http://data.uis.unesco.org/RestSDMX/sdmx.ashx", TRUE)
      )
      
  )
  .rsdmx.options$providers <- listOfProviders
}


#function to add a SDMX provider
addSDMXServiceProvider <- function(provider){
  .rsdmx.options$providers <- c(.rsdmx.options$providers, provider)
}


#function to retrieve the list of SDMX service providers
#(default ones, and/or providers configured by the user)
getSDMXServiceProviders <- function(){
  return(.rsdmx.options$providers)
}


#find a service provider
findSDMXServiceProvider <- function(agencyId){
  res <- unlist(lapply(getSDMXServiceProviders(), function(x) {if(x@agencyId == agencyId){return(x)}}))
  if(!is.null(res) && length(res) > 0) res <- res[[1]]
  return(res)
}
