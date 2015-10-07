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
          compliant = TRUE)
      ),
      
      #UN-ILO
      SDMXServiceProvider(
        agencyId = "ILO", name = "International Labour Organization of the United Nations",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
          repoUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
          compliant = TRUE)                  
      ),
      
      #UIS (UNESCO)
      SDMXServiceProvider(
        agencyId = "UIS", name = "UNESCO Institute of Statistics",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://data.uis.unesco.org/RestSDMX/sdmx.ashx",
          repoUrl = "http://data.uis.unesco.org/RestSDMX/sdmx.ashx", 
          compliant = TRUE)
      ),
      
      #national data providers
      #-----------------------
      
      #NBB {Belgium}
      SDMXServiceProvider(
        agencyId = "NBB", name = "National Bank of Belgium",
        scale = "national", country = "BEL",
        builder = SDMXRESTRequestBuilder(
          regUrl = "http://stat.nbb.be/RestSDMX/sdmx.ashx",
          repoUrl = "http://stat.nbb.be/RestSDMX/sdmx.ashx", 
          compliant = FALSE)
      )
      
  )
  .rsdmx.options$providers <- new("SDMXServiceProviders", providers = listOfProviders)
  
} # nocov end


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
