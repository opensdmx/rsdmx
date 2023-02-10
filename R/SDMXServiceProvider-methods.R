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
#'   myBuilder <- SDMXREST20RequestBuilder(regUrl = "http://www.myorg.org/registry",
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
    
  #international data providers
  #----------------------------

  #BIS
  BIS <- SDMXServiceProvider(
   agencyId = "BIS", name = "Bank for International Settlements",
   builder = SDMXREST21RequestBuilder(
     regUrl = "https://stats.bis.org/api/v1",
     repoUrl = "https://stats.bis.org/api/v1",
     compliant = TRUE
   )
  )
  
  #ECB
  ECB <- SDMXServiceProvider(
    agencyId = "ECB", name = "European Central Bank",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://sdw-wsrest.ecb.europa.eu/service",
      repoUrl = "https://sdw-wsrest.ecb.europa.eu/service",
      compliant = TRUE)
  )

  #EUROSTAT
  ESTAT <- SDMXServiceProvider( 
    agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union)",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1",
      repoUrl = "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1",
      compliant = TRUE)
  )
  ESTAT@builder@handler$dataflow = function(obj){
    if(is.null(obj@resourceId)) obj@resourceId = "all"
    if(is.null(obj@version)) obj@version = "latest"
    req <- sprintf("%s/dataflow/ESTAT/%s/%s/",obj@regUrl, obj@resourceId, obj@version)        
    return(req)
  }
  ESTAT@builder@handler$datastructure = function(obj){
    if(is.null(obj@resourceId)) obj@resourceId = "all"
    if(is.null(obj@version)) obj@version = "latest"
    req <- sprintf("%s/datastructure/ESTAT/%s/%s/",obj@regUrl, obj@resourceId, obj@version)
    req <- paste0(req, "?references=children") #TODO to see later to have arg for this
    return(req)
  }
  
  #ESTAT_COMEXT
  ESTAT_COMEXT <- SDMXServiceProvider( 
    agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union) - COMEXT",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://ec.europa.eu/eurostat/api/comext/dissemination/sdmx/2.1",
      repoUrl = "https://ec.europa.eu/eurostat/api/comext/dissemination/sdmx/2.1",
      compliant = TRUE)
  )
  ESTAT_COMEXT@builder@handler$dataflow = ESTAT@builder@handler$dataflow
  ESTAT_COMEXT@builder@handler$datastructure = ESTAT@builder@handler$datastructure
  
  #ESTAT_GROW
  ESTAT_GROW <- SDMXServiceProvider( 
    agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union) - DG GROW",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://webgate.ec.europa.eu/grow/redisstat/api/dissemination/sdmx/2.1",
      repoUrl = "https://webgate.ec.europa.eu/grow/redisstat/api/dissemination/sdmx/2.1",
      compliant = TRUE)
  )
  ESTAT_GROW@builder@handler$dataflow = ESTAT@builder@handler$dataflow
  ESTAT_GROW@builder@handler$datastructure = ESTAT@builder@handler$datastructure
  
  #ESTAT_COMP
  ESTAT_COMP <- SDMXServiceProvider( 
    agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union) - DG COMP",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://webgate.ec.europa.eu/comp/redisstat/api/dissemination/sdmx/2.1",
      repoUrl = "https://webgate.ec.europa.eu/comp/redisstat/api/dissemination/sdmx/2.1",
      compliant = TRUE)
  )
  ESTAT_COMP@builder@handler$dataflow = ESTAT@builder@handler$dataflow
  ESTAT_COMP@builder@handler$datastructure = ESTAT@builder@handler$datastructure
  
  #ESTAT_EMPL
  ESTAT_EMPL <- SDMXServiceProvider( 
    agencyId = "ESTAT", name = "Eurostat (Statistical office of the European Union) - DG EMPL",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://webgate.ec.europa.eu/empl/redisstat/api/dissemination/sdmx/2.1",
      repoUrl = "https://webgate.ec.europa.eu/empl/redisstat/api/dissemination/sdmx/2.1",
      compliant = TRUE)
  )
  ESTAT_EMPL@builder@handler$dataflow = ESTAT@builder@handler$dataflow
  ESTAT_EMPL@builder@handler$datastructure = ESTAT@builder@handler$datastructure
  
  #IMF
  IMF <- SDMXServiceProvider(
    agencyId = "IMF", name = "International Monetary Fund",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://sdmxcentral.imf.org/ws/public/sdmxapi/rest",
      repoUrl = "https://sdmxcentral.imf.org/ws/public/sdmxapi/rest",
      compliant = TRUE)
  )
    
  #OECD
  OECD <- SDMXServiceProvider(
    agencyId = "OECD", name = "Organisation for Economic Cooperation and Development ",
    builder = SDMXDotStatRequestBuilder(
      regUrl = "https://stats.oecd.org/restsdmx/sdmx.ashx",
      repoUrl = "https://stats.oecd.org/restsdmx/sdmx.ashx")
  )
  
  #UNICEF
  UNICEF <- SDMXServiceProvider(
    agencyId = "UNICEF", "United Nations International Children's Emergency Fund",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://sdmx.data.unicef.org/ws/public/sdmxapi/rest",
      repoUrl = "https://sdmx.data.unicef.org/ws/public/sdmxapi/rest",
      compliant = TRUE
    )
  )
   
  #COUNTDOWN 2030
  CD2030 <- SDMXServiceProvider(
    agencyId = "CD2030", "United Nations International Children's Emergency Fund",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://sdmx.data.unicef.org/ws/public/sdmxapi/rest",
      repoUrl = "https://sdmx.data.unicef.org/ws/public/sdmxapi/rest",
      compliant = TRUE
    )
  )
  
  #UNSD
  UNSD <- SDMXServiceProvider(
    agencyId = "UNSD", "United Nations Statistics Division",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://data.un.org/WS/rest",
      repoUrl = "http://data.un.org/WS/rest",
      compliant = TRUE
    )
  )  
  
  #UN-ILO (Legacy)
  ILO_Legacy <- SDMXServiceProvider(
    agencyId = "ILO_Legacy", name = "International Labour Organization of the United Nations",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
      repoUrl = "http://www.ilo.org/ilostat/sdmx/ws/rest",
      compliant = FALSE, skipProviderId = TRUE,
      unsupportedResources = list("dataflow"))                  
  )
  
  #UN-ILO
  ILO <- SDMXServiceProvider(
    agencyId = "ILO", name = "International Labour Organization of the United Nations",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://www.ilo.org/sdmx/rest",
      repoUrl = "https://www.ilo.org/sdmx/rest",
      compliant = TRUE, skipProviderId = TRUE)                  
  )
  
  #WBG_WITS (World Integrated Trade Solution)
  WBG_WITS <- SDMXServiceProvider(
    agencyId = "WBG_WITS", name = "World Integrated Trade Solution",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://wits.worldbank.org/API/V1/SDMX/V21/rest",
      repoUrl = "http://wits.worldbank.org/API/V1/SDMX/V21/rest",
      compliant = TRUE, skipProviderId = TRUE
    )
  )
  
  #WB (World Bank)
  WB <- SDMXServiceProvider(
    agencyId = "WB", name = "World Bank",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://api.worldbank.org/v2/sdmx/rest",
      repoUrl = "http://api.worldbank.org/v2/sdmx/rest",
      compliant = TRUE, skipProviderId = TRUE
    )
  )

  #PDH.STAT (Pacific Data Hub by The Pacific Community)
  PDH <- SDMXServiceProvider(
    agencyId = "PDH", name = "Pacific Data Hub DotStat",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://stats-nsi-stable.pacificdata.org/rest",
      repoUrl = "https://stats-nsi-stable.pacificdata.org/rest",
      compliant = FALSE) 
  )
  
  #national data providers
  #-----------------------
  
  #ABS {Australia}
  ABS <- SDMXServiceProvider(
    agencyId = "ABS", name = "Australian Bureau of Statistics",
    scale = "national", country = "AUS",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://api.data.abs.gov.au",
      repoUrl = "https://api.data.abs.gov.au", 
      compliant = TRUE)
  )
  
  #NBB {Belgium}
  NBB <- SDMXServiceProvider(
    agencyId = "NBB", name = "National Bank of Belgium",
    scale = "national", country = "BEL",
    builder = SDMXDotStatRequestBuilder(
      regUrl = "https://stat.nbb.be/RestSDMX/sdmx.ashx",
      repoUrl = "https://stat.nbb.be/RestSDMX/sdmx.ashx", 
      unsupportedResources = list("dataflow"))
  )
  
  #INSEE {France}
  INSEE <- SDMXServiceProvider(
    agencyId = "INSEE", name = "Institut national de la statistique et des \u00e9tudes \u00e9conomiques",
    scale = "national", country = "FRA",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://bdm.insee.fr/series/sdmx",
      repoUrl = "https://bdm.insee.fr/series/sdmx", 
      compliant = TRUE)
  )
  
  #INEGI (Mexico)
  INEGI <- SDMXServiceProvider(
    agencyId = "INEGI", name = "Instituto Nacional de Estad\u00edstica y Geograf\u00eda (M\u00e9jico)",
    scale = "national", country = "MEX",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://sdmx.snieg.mx/service/Rest",
      repoUrl = "http://sdmx.snieg.mx/service/Rest",
      compliant = FALSE
    )
  )
  
  #ISTAT (Italy)
  ISTAT <- SDMXServiceProvider(
    agencyId = "ISTAT", name = "Istituto nazionale di statistica (Italia)",
    scale = "national", country = "ITA",
    builder = SDMXREST21RequestBuilder(
      regUrl = "http://sdmx.istat.it/SDMXWS/rest",
      repoUrl = "http://sdmx.istat.it/SDMXWS/rest",
      compliant = TRUE
    )
  )
  
  #NOMIS (UK Official Labour Market statistics)
  NOMIS <- SDMXServiceProvider(
    agencyId = "NOMIS", name = "NOMIS - UK Official Labour Market Statistics",
    scale = "national", country = "UK",
    builder = SDMXRequestBuilder(
      regUrl = "https://www.nomisweb.co.uk/api/v01",
      repoUrl = "https://www.nomisweb.co.uk/api/v01",
      compliant = FALSE,
      formatter = list(
        dataflow = function(obj){return(obj)},
        datastructure = function(obj){return(obj)},
        data = function(obj){return(obj)}
      ),
      handler = list(
        
        #'dataflow' resource (path="dataset/{resourceId}/def.sdmx.xml")
        #-----------------------------------------------------------------------
        dataflow = function(obj){  
          req <- sprintf("%s/dataset", obj@regUrl)
          if(!is.null(obj@resourceId)) req <- paste(req, obj@resourceId, sep="/")
          req <- paste(req, "def.sdmx.xml", sep="/")
          return(req)
        },
        #'datastructure' resource (path="dataset/{resourceID}.structure.sdmx.xml")
        #-----------------------------------------------------------------------
        datastructure = function(obj){
          req <- sprintf("%s/dataset", obj@regUrl)
          if(is.null(obj@resourceId)) stop("Missing 'resourceId' value")
          req <- paste(req, obj@resourceId, sep="/")
          req <- paste0(req, ".structure.sdmx.xml")
          return(req)
        },
        #'data' resource (path="dataset/{resourceID}.generic.sdmx.xml")
        #----------------------------------------------------------
        data = function(obj){
          req <- sprintf("%s/dataset", obj@repoUrl)
          if(is.null(obj@flowRef)) stop("Missing 'flowRef' value")
          req <- paste(req, obj@flowRef, sep="/")
          req <- paste0(req, ".compact.sdmx.xml")
          return(req)
        }
      )
    )
  )
  
  #LSD - Lithuanian Department of Statistics (Statistics Lithuania)
  LSD <- SDMXServiceProvider(
    agencyId = "LSD", "Statistics Lithuania",
    scale = "national", country = "LTU",
    builder = SDMXREST21RequestBuilder(
      regUrl = "https://osp-rs.stat.gov.lt/rest_xml",
      repoUrl = "https://osp-rs.stat.gov.lt/rest_xml",
      compliant = TRUE, skipProviderId = TRUE
    )
  )
  
  #NCSI - Sultanate of Oman - National Center for Statistics & Information
  #Based on KNOEMA SDMX server implementation
  NCSI <- SDMXServiceProvider(
    agencyId = "NCSI", "Sultanate of Oman - National Center for Statistics & Information",
    scale = "national", country = "OMN",
    builder = SDMXRequestBuilder(
      regUrl = "https://data.gov.om/api/1.0/sdmx",
      repoUrl = "https://data.gov.om/api/1.0/sdmx",
      formatter = list(
        dataflow = function(obj){return(obj)},
        datastructure = function(obj){return(obj)},
        data = function(obj){return(obj)}
      ),
      handler = list(
        
        #'dataflow' resource (path="/")
        #-----------------------------------------------------------------------
        dataflow = function(obj){
          return(obj@regUrl)
        },
        #'datastructure' resource (path="/{resourceID})
        #-----------------------------------------------------------------------
        datastructure = function(obj){
          req <- paste(obj@regUrl, obj@resourceId, sep = "/")
          return(req)
        },
        #'data' resource (path="getdata?dataflow={flowRef}&key={key})
        #----------------------------------------------------------
        data = function(obj){
          if(is.null(obj@flowRef)) stop("Missing flowRef value")
          if(is.null(obj@key)) obj@key = "."
          
          #base data request
          req <- sprintf("%s/data/%s/%s?", obj@repoUrl, obj@flowRef, obj@key)
          
          #DataQuery
          #-> temporal extent (if any)
          if(!is.null(obj@start)) {
            req <- paste0(req, "startPeriod=",obj@start)
          }
          if(!is.null(obj@end)) {
            if(!grepl("\\?$", req)) req <- paste0(req,"&")
            req <- paste0(req, "endPeriod=",obj@end)
          }
          
          return(req)
        }
      ),
      compliant = FALSE
    )
  )
  
  #STAT_EE - Statistics Estonia database {Estonia}
  STAT_EE <- SDMXServiceProvider(
    agencyId = "STAT_EE", name = "Statistics Estonia database",
    scale = "national", country = "EST",
    builder = SDMXDotStatRequestBuilder(
      regUrl = "http://andmebaas.stat.ee/restsdmx/sdmx.ashx",
      repoUrl = "http://andmebaas.stat.ee/restsdmx/sdmx.ashx",
      unsupportedResources = list("dataflow")
    )
  )
  
  #UKDS removed - no support for SDMX-JSON in rsdmx at now
  #UKDS <- SDMXServiceProvider(
  #  agencyId = "UKDS", name = "United Kingdom Data Service",
  #  scale = "national", country = "UK",
  #  builder = SDMXDotStatRequestBuilder(
  #    regUrl = "http://stats.ukdataservice.ac.uk/restsdmx/sdmx.ashx",
  #    repoUrl = "http://stats.ukdataservice.ac.uk/restsdmx/sdmx.ashx",
  #    unsupportedResources = list("dataflow")
  #  )
  #)
  
  #Bundesbank
  BBK <- SDMXServiceProvider(
    agencyId = "BBK", name = "Bundesbank",
    scale = "national", country = "DEU",
    builder = SDMXRequestBuilder(
      regUrl = "https://api.statistiken.bundesbank.de/rest/metadata",
      repoUrl = "https://api.statistiken.bundesbank.de/rest",
      formatter = list(
        dataflow = function(obj){return(obj)},
        datastructure = function(obj){return(obj)},
        data = function(obj){return(obj)}
      ),
      #resource handler
      handler = list(
        
        #dataflow resource (dataflow/agencyID/resourceID/version)
        #-----------------------------------------------------------------------
        dataflow = function(obj){
          req <- sprintf("%s/dataflow/%s",obj@regUrl, obj@providerId)
          if(!is.null(obj@resourceId)) req <- paste(req, obj@resourceId, sep = "/")
          return(req)
        },
        
        #datastructure resource (datastructure/agencyID/resourceID/version)
        #--------------------------------------------------------------------------------
        datastructure = function(obj){
          req <- sprintf("%s/datastructure/%s",obj@regUrl, obj@providerId)
          if(!is.null(obj@resourceId)) req <- paste(req, obj@resourceId, sep = "/")
          req <- paste0(req, "?references=children") #TODO to see later to have arg for this
          return(req)
        },
        
        #data resource (data/flowRef/key/providerRef)
        #----------------------------------------------------------
        data = function(obj){
          if(is.null(obj@flowRef)) stop("Missing flowRef value")
          req <- sprintf("%s/data/%s/%s",obj@repoUrl, obj@flowRef, obj@key)
          
          #DataQuery
          #-> temporal extent (if any)
          addParams = FALSE
          if(!is.null(obj@start)){
            req <- paste0(req, "?")
            addParams = TRUE
            req <- paste0(req, "startPeriod=", obj@start)
          }
          if(!is.null(obj@end)){
            if(!addParams){
              req <- paste0(req, "?")
            }else{
              req <- paste0(req, "&")
            }
            req <- paste0(req, "endPeriod=", obj@end) 
          }
          
          return(req)
        }
      ),
      compliant = FALSE
    )
  )
  
  
  #other data providers
  #--------------------
  
  #KNOEMA (Open data plateform)
  KNOEMA <- SDMXServiceProvider(
    agencyId = "KNOEMA", name = "KNOEMA knowledge plateform",
    builder = SDMXRequestBuilder(
      regUrl = "http://knoema.fr/api/1.0/sdmx",
      repoUrl = "http://knoema.fr/api/1.0/sdmx",
      formatter = list(
        dataflow = function(obj){return(obj)},
        datastructure = function(obj){return(obj)},
        data = function(obj){return(obj)}
      ),
      handler = list(
                                  
        #'dataflow' resource (path="/")
        #-----------------------------------------------------------------------
        dataflow = function(obj){
          return(obj@regUrl)
        },
        #'datastructure' resource (path="/{resourceID})
        #-----------------------------------------------------------------------
        datastructure = function(obj){
          req <- paste(obj@regUrl, obj@resourceId, sep = "/")
          return(req)
        },
        #'data' resource (path="getdata?dataflow={flowRef}&key={key})
        #----------------------------------------------------------
        data = function(obj){
          if(is.null(obj@flowRef)) stop("Missing flowRef value")
          if(is.null(obj@key)) obj@key = "."
          
          #base data request
          req <- sprintf("%s/getdata?dataflow=%s&key=%s", obj@repoUrl, obj@flowRef, obj@key)
          
          #DataQuery
          #-> temporal extent (if any)
          if(!is.null(obj@start) | !is.null(obj@end)) {
            warning("start/end parameters ignored for this SDMX API")
          }
          
          return(req)
        }
      ),
      compliant = FALSE
    )
  )
  
  listOfProviders <- list(
    #international
    BIS, ECB, ESTAT,ESTAT_COMEXT, ESTAT_COMP, ESTAT_GROW, ESTAT_EMPL, IMF, OECD, UNICEF, CD2030, UNSD, ILO_Legacy, ILO, WBG_WITS, WB, PDH,
    #national
    ABS, NBB, INSEE, INEGI, ISTAT, NOMIS, LSD, NCSI, STAT_EE, BBK,
    #others
    KNOEMA
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
#'   myBuilder <- SDMXREST20RequestBuilder(regUrl = "http://www.myorg.org/registry",
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
  if(is.null(agencyId)) return(NULL)
  res <- unlist(lapply(slot(getSDMXServiceProviders(),"providers"),
                       function(x) {if(x@agencyId == agencyId){return(x)}}))
  if(!is.null(res) && length(res) > 0) res <- res[[1]]
  return(res)
}
