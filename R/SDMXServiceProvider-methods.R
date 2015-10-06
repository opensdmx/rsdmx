# E.Blondel - 2015/09/22
#========================

#constructor
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

#function to set a well-known list of SDMX service providers
setSDMXServiceProviders <- function(){
  
  listOfProviders <- list(
    
      #ECB
      SDMXServiceProvider(
        agencyId = "ECB", name = "European Central Bank",
        builder = SDMXRESTRequestBuilder("https://sdw-wsrest.ecb.europa.eu/service", TRUE)
      ),
    
      #EUROSTAT
      SDMXServiceProvider( 
        agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union)",
        builder = SDMXRESTRequestBuilder("http://ec.europa.eu/eurostat/SDMX/diss-web/rest", TRUE)
      ),
    
      #OECD
      SDMXServiceProvider(
        agencyId = "OECD", name = "Organisation for Economic Cooperation and Development ",
        builder = SDMXRESTRequestBuilder("http://stats.oecd.org/restsdmx/sdmx.ashx", FALSE)
      ),
      
      #UN-FAO
      SDMXServiceProvider(
        agencyId = "FAO", name = "Food and Agriculture Organization of the United Nations",
        builder = SDMXRESTRequestBuilder("http://data.fao.org/sdmx/repository", TRUE)
      ),
      
      #UN-ILO
      SDMXServiceProvider(
        agencyId = "ILO", name = "International Labour Organization of the United Nations",
        builder = SDMXRESTRequestBuilder("http://www.ilo.org/ilostat/sdmx/ws/rest", TRUE)                  
      ),
      
      #UIS (UNESCO)
      SDMXServiceProvider(
        agencyId = "UIS", name = "UNESCO Institute of Statistics",
        builder = SDMXRESTRequestBuilder("http://data.uis.unesco.org/RestSDMX/sdmx.ashx", TRUE)
      )
      
  )
  .rsdmx.options$providers <- new("SDMXServiceProviders", providers = listOfProviders)
}


#function to add a SDMX provider
addSDMXServiceProvider <- function(provider){
  .rsdmx.options$providers <- new("SDMXServiceProviders",
                                  providers = c(slot(.rsdmx.options$providers, "providers"), provider)
                              )
}


#function to retrieve the list of SDMX service providers
#(default ones, and/or providers configured by the user)
getSDMXServiceProviders <- function(){
  out <- .rsdmx.options$providers
  return(out)
}


#find a service provider
findSDMXServiceProvider <- function(agencyId){
  res <- unlist(lapply(slot(getSDMXServiceProviders(),"providers"),
                       function(x) {if(x@agencyId == agencyId){return(x)}}))
  if(!is.null(res) && length(res) > 0) res <- res[[1]]
  return(res)
}
