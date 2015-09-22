# E.Blondel - 2015/09/22
#========================

#constructor
SDMXServiceProvider <- function(id, name, builder) {
  new("SDMXServiceProvider", id = id, name = name, builder = builder);
}

#other non-S4 methods
#====================

#function to set a well-known list of SDMX service providers
setSDMXServiceProviders <- function(){
  
  listOfProviders <- list(
    
      #ECB
      SDMXServiceProvider(
        "ECB", "European Central Bank",
        SDMX21RequestBuilder("https://sdw-wsrest.ecb.europa.eu/service", "")
      ),
    
      #EUROSTAT
      SDMXServiceProvider(
        "EUROSTAT", "Eurostat (Statistical office of the European Union)",
        SDMX21RequestBuilder("http://ec.europa.eu/eurostat/SDMX/diss-web/rest", "")
      ),
    
      #OECD
      SDMXServiceProvider(
        "OECD", "Organisation for Economic Cooperation and Development ",
        SDMX21RequestBuilder("http://stats.oecd.org/restsdmx/sdmx.ashx", "OECD")
      ),
      
      #UN-FAO
      SDMXServiceProvider(
        "UN-FAO", "Food and Agriculture Organization of the United Nations",
        SDMX21RequestBuilder("http://data.fao.org/sdmx/repository", "FAO")
      ),
      
      #UN-ILO
      SDMXServiceProvider(
        "UN-ILO", "International Labour Organization of the United Nations",
        SDMX21RequestBuilder("http://www.ilo.org/ilostat/sdmx/ws/rest", "")                  
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
findSDMXServiceProvider <- function(id){
  res <- unlist(lapply(getSDMXServiceProviders(), function(x) {if(x@id == id){return(x)}}))
  return(res)
}
