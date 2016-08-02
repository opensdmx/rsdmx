#' @name readSDMX
#' @aliases readSDMX
#' @title readSDMX
#' @description \code{readSDMX} is the main function to use to read SDMX data
#'
#' @usage readSDMX(file, isURL,
#'                 provider, providerId, agencyId, resource, resourceId, version,
#'                 flowRef, key, key.mode, start, end, dsd, validate, verbose)
#'                 
#' @param file path to SDMX-ML document that needs to be parsed
#' @param isURL a value of class "logical" either the path is an url, and data 
#'        has to be downloaded from a SDMXweb-repository. Default value is TRUE.
#'        Ignored in case \code{readSDMX} is used with helpers (based on the 
#'        embedded list of \code{SDMXServiceProvider})
#' @param provider an object of class "SDMXServiceProvider". If specified, 
#'        \code{file} and \code{isURL} arguments will be ignored.      
#' @param providerId an object of class "character" representing a provider id. 
#'        It has to be match a default provider as listed in\code{getSDMXServiceProviders()}
#' @param agencyId an object of class "character representing an agency id, for
#'        which data should be requested (from a particular service provider)      
#' @param resource an object of class "character" giving the SDMX service request 
#'        resource to query e.g. "data". Recognized if a valid provider or provide 
#'        id has been specified as argument.
#' @param resourceId an object of class "character" giving a SDMX service resource 
#'        Id, e.g. the id of a data structure
#' @param version an object of class "character" giving a SDMX resource version, 
#'        e.g. the version of a dataflow.
#' @param flowRef an object of class "character" giving the SDMX flow ref id. Recognized 
#'        if valid provider or provide id has been specified as argument.
#' @param key an object of class "character" or "list" giving the SDMX data key/filter 
#'        to apply. Recognized if a valid provider or provide id has been specified as argument.
#'        If \code{key.mode} is equal to \code{"R"} (default value), filter has to be an object 
#'        of class "list" representing the filters to apply to the dataset, otherwise the filter 
#'        will be a string.
#' @param key.mode an object of class "character" indicating if the \code{key} has to be provided 
#'        as an R object, ie a object of class "list" representing the filter(s) to apply. Default 
#'        value is \code{"R"}. Alternative value is \code{"SDMX"}
#' @param start an object of class "integer" or "character" giving the SDMX start time to apply. 
#'        Recognized if a valid provider or provide id has been specified as argument.
#' @param end an object of class "integer" or "character" giving the SDMX end time to apply. 
#'        Recognized if a valid provider or provide id has been specified as argument.
#' @param dsd an Object of class "logical" if an attempt to inherit the DSD should be performed.
#'        Active only if \code{"readSDMX"} is used as helper method (ie if data is fetched using 
#'        an embedded service provider. Default is FALSE
#' @param validate an object of class "logical" indicating if a validation check has to
#'        be performed on the SDMX-ML document to check its SDMX compliance when reading it.
#'        Default is FALSE.
#' @param verbose an Object of class "logical" that indicates if rsdmx messages should
#'        appear to user. Default is TRUE.
#' 
#' @return an object of class "SDMX"
#' 
#' @examples             
#'  # SDMX datasets
#'  #--------------
#'  \dontrun{
#'    # Not run
#'    # (local dataset examples)
#'    #with SDMX 2.0
#'    tmp <- system.file("extdata","Example_Eurostat_2.0.xml", package="rsdmx")
#'    sdmx <- readSDMX(tmp, isURL = FALSE)
#'    stats <- as.data.frame(sdmx)
#'    head(stats)
#'    
#'    #with SDMX 2.1
#'    tmpnew <- system.file("extdata","Example_Eurostat_2.1.xml", package="rsdmx")
#'    sdmx <- readSDMX(tmpnew, isURL = FALSE)
#'    stats <- as.data.frame(sdmx)
#'    head(stats)
#'    ## End(**Not run**)
#'  }
#'  
#'  \donttest{
#'    # Not run by 'R CMD check'
#'    # (reliable remote datasource but with possible occasional unavailability)
#'    
#'    #examples using embedded providers
#'    sdmx <- readSDMX(providerId = "OECD", resource = "data", flowRef = "MIG",
#'                      key = list("TOT", NULL, NULL), start = 2011, end = 2011)
#'    stats <- as.data.frame(sdmx)
#'    head(stats)
#'    
#'    #examples using 'file' argument
#'    #using url (Eurostat REST SDMX 2.1)
#'    url <- paste("http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/",
#'                  "cdh_e_fos/..PC.FOS1.BE/?startperiod=2011&endPeriod=2011",
#'                  sep = "")
#'    sdmx <- readSDMX(url)
#'    stats <- as.data.frame(sdmx)
#'    head(stats)
#'    
#'    ## End(**Not run**)
#'  }
#'  
#'  # SDMX Concepts / ConceptSchemes
#'  #-------------------------------
#'  \donttest{
#'    # Not run by 'R CMD check'
#'    # (reliable remote datasource but with possible occasional unavailability)
#'    csUrl <- paste("http://data.fao.org/sdmx/registry/conceptscheme",
#'                   "/FAO/ALL/LATEST/?detail=full&references=none&version=2.1",
#'                   sep = "")
#'    csobj <- readSDMX(csUrl)
#'    csdf <- as.data.frame(csobj)
#'    head(csdf)
#'    ## End(**Not run**)
#'  }
#'  
#'  # SDMX Codelists
#'  #---------------
#'  \donttest{
#'    # Not run by 'R CMD check'
#'    # (reliable remote datasource but with possible occasional unavailability)
#'    clUrl <- "http://data.fao.org/sdmx/registry/codelist/FAO/CL_FAO_MAJOR_AREA/0.1"
#'    clobj <- readSDMX(clUrl)
#'    cldf <- as.data.frame(clobj)
#'    head(cldf)
#'    ## End(**Not run**)
#'  }
#'  
#'  # SDMX DataStructureDefinition (DSD)
#'  #-----------------------------------
#'  \donttest{
#'    # Not run by 'R CMD check'
#'    # (reliable remote datasource but with possible occasional unavailability)
#'    
#'    #using embedded providers
#'    dsd <- readSDMX(providerId = "OECD", resource = "datastructure",
#'                    resourceId = "WATER_ABSTRACT")
#'    
#'    #get codelists from DSD
#'    cls <- slot(dsd, "codelists")
#'    codelists <- sapply(slot(cls,"codelists"), slot, "id") #get list of codelists
#'    
#'    #get a codelist
#'    codelist <- as.data.frame(cls, codelistId = "CL_WATER_ABSTRACT_SOURCE")
#'    
#'    #get concepts from DSD
#'    concepts <- as.data.frame(slot(dsd, "concepts"))
#'    
#'    ## End(**Not run**)
#'  }
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'    

readSDMX <- function(file = NULL, isURL = TRUE,
                     provider = NULL, providerId = NULL,
                     agencyId = NULL, resource = NULL, resourceId = NULL, version = NULL,
                     flowRef = NULL, key = NULL, key.mode = "R", start = NULL, end = NULL, dsd = FALSE,
                     validate = FALSE, verbose = TRUE) {
  
  #set option for SDMX compliance validation
  .rsdmx.options$validate = validate
  
  if(!(key.mode %in% c("R", "SDMX"))){
    stop("Invalid value for key.mode argument. Accepted values are 'R', 'SDMX' ")
  }
  
  #check from arguments if request has to be performed
  buildRequest <- FALSE
  if(!is.null(provider)){
    if(class(provider) != "SDMXServiceProvider"){
      stop("Provider should be an instance of 'SDMXServiceProvider'")
    }
    buildRequest <- TRUE
  }
  
  if(!is.null(providerId)){
    provider <- findSDMXServiceProvider(providerId)
    if(is.null(provider)){
      stop("No provider with identifier ", providerId)
    }
    buildRequest <- TRUE
  }
  
  #proceed with the request build
  if(buildRequest){
    
    if(is.null(resource)) stop("SDMX service resource cannot be null")
    
    #request handler
    requestHandler <- provider@builder@handler
    if((resource %in% provider@builder@unsupportedResources) ||
       !(resource %in% names(requestHandler)))
      stop("Unsupported SDMX service resource for this provider")
    
    #apply SDMX key mode
    if(key.mode == "R" && !missing(key) && !is.null(key)){
      key <- paste(sapply(key, paste, collapse = "+"), collapse=".")
    }
    
    #request params
    requestParams <- SDMXRequestParams(
                       regUrl = provider@builder@regUrl,
                       repoUrl = provider@builder@repoUrl,
                       providerId = providerId,
                       agencyId = agencyId,
                       resource = resource,
                       resourceId = resourceId,
                       version = version,
                       flowRef = flowRef,
                       key = key,
                       start = start,
                       end = end,
                       compliant = provider@builder@compliant
                     )
    #formatting requestParams
    requestFormatter <- provider@builder@formatter
    requestParams <- switch(resource,
                           "dataflow" = requestFormatter$dataflow(requestParams),
                           "datastructure" = requestFormatter$datastructure(requestParams),
                           "data" = requestFormatter$data(requestParams))
    #preparing request
    file <- switch(resource,
                  "dataflow" = requestHandler$dataflow(requestParams),
                  "datastructure" = requestHandler$datastructure(requestParams),
                  "data" = requestHandler$data(requestParams)
    )
    if(verbose) message(paste0("-> Fetching '", file, "'"))
  }
  
  #call readSDMX original
  if(is.null(file)) stop("Empty file argument")
  if(buildRequest) isURL = TRUE
  
  #load data
  status <- 0
  if(isURL == FALSE){
    if(!file.exists(file))
      stop("File ", file, "not found\n")
    xmlObj <- xmlTreeParse(file, useInternalNodes = TRUE)
    status <- 1
  }else{
    rsdmxAgent <- paste("rsdmx/",as.character(packageVersion("rsdmx")),sep="")
    content <- getURL(file, httpheader = list('User-Agent' = rsdmxAgent),
                      ssl.verifypeer = FALSE, .encoding = "UTF-8")
    
    status <- tryCatch({
      if((attr(regexpr("<!DOCTYPE html>", content), "match.length") == -1) && 
         (attr(regexpr("<html>", content), "match.length") == -1)){
        
        #check the presence of a BOM
        BOM <- "\ufeff"
        if(attr(regexpr(BOM, content), "match.length") != - 1){
          content <- gsub(BOM, "", content)
        }
        
        #check presence of XML comments
        content <- gsub("<!--.*?-->", "", content)
        
        xmlObj <- xmlTreeParse(content, useInternalNodes = TRUE)
        status <- 1
      }else{
        stop("The SDMX web-request failed. Please retry")
      }
    },error = function(err){
      print(err)
      status <<- 0
      return(status)
    })
  }
  
  #internal function for SDMX Structure-based document
  getSDMXStructureObject <- function(xmlObj, ns, resource){
    strTypeObj <- SDMXStructureType(xmlObj, ns, resource)
    strType <- getStructureType(strTypeObj)
    strObj <- switch(strType,
                     "DataflowsType" = SDMXDataFlows(xmlObj, ns),
                     "ConceptsType" = SDMXConcepts(xmlObj, ns),
                     "CodelistsType" = SDMXCodelists(xmlObj, ns),
                     "DataStructuresType" = SDMXDataStructures(xmlObj, ns),
                     "DataStructureDefinitionsType" = SDMXDataStructureDefinition(xmlObj, ns),
                     NULL
    )
    return(strObj)
  }  
  
  #encapsulate in S4 object
  obj <- NULL
  if(status){ 
    
    #namespaces
    ns <- namespaces.SDMX(xmlObj)
    
    #convenience for SDMX documents embedded in SOAP XML responses
    if(isSoapRequestEnvelope(xmlObj, ns)){
      xmlObj <- getSoapRequestResult(xmlObj)
    }
    
    #convenience for SDMX documents queried through a RegistryInterface
    if(isRegistryInterfaceEnvelope(xmlObj, TRUE)){
      xmlObj <- getRegistryInterfaceResult(xmlObj)
    }
    
    type <- SDMXType(xmlObj)@type
    obj <- switch(type,
                  "StructureType"             = getSDMXStructureObject(xmlObj, ns, resource),
                  "GenericDataType"           = SDMXGenericData(xmlObj, ns),
                  "CompactDataType"           = SDMXCompactData(xmlObj, ns),
                  "UtilityDataType"           = SDMXUtilityData(xmlObj, ns),
                  "StructureSpecificDataType" = SDMXStructureSpecificData(xmlObj, ns),
                  "StructureSpecificTimeSeriesDataType" = SDMXStructureSpecificTimeSeriesData(xmlObj, ns),
                  "CrossSectionalDataType"    = SDMXCrossSectionalData(xmlObj, ns),
                  "MessageGroupType"          = SDMXMessageGroup(xmlObj, ns),
                  NULL
    ) 
    
    if(is.null(obj)){
      if(type == "StructureType"){
        strTypeObj <- SDMXStructureType(xmlObj, ns, resource)
        type <- getStructureType(strTypeObj)
      }
      stop(paste("Unsupported SDMX Type '",type,"'",sep=""))
      
    }else{
      
      #handling footer messages
      footer <- slot(obj, "footer")
      footer.msg <- slot(footer, "messages") 
      if(length(footer.msg) > 0){
        invisible(
          lapply(footer.msg,
                 function(x){
                   code <- slot(x,"code")
                   severity <- slot(x,"severity")
                   lapply(slot(x,"messages"),
                          function(msg){
                            warning(paste(severity," (Code ",code,"): ",msg,sep=""),
                                    call. = FALSE)
                          }
                   )
                 })	
        )
      }
    }
  }
  
  #attempt to get DSD in case of helper method
  if(buildRequest && resource %in% c("data","dataflow") && dsd){
    
    if(resource == "data" && providerId %in% c("ESTAT", "ISTAT", "WBG_WITS")){
      if(verbose) message("-> Attempt to fetch DSD ref from dataflow description")
      flow <- readSDMX(providerId = providerId, resource = "dataflow",
                      resourceId = flowRef, verbose = TRUE)
      dsdRef <- slot(slot(flow, "dataflows")[[1]],"dsdRef")
      rm(flow)
    }else{
      dsdRef <- NULL
      if(resource == "data"){
        dsdRef <- slot(obj, "dsdRef")
      }else if(resource=="dataflow"){
        dsdRef <- lapply(slot(obj,"dataflows"), slot,"dsdRef")
      }
      if(!is.null(dsdRef)){
        if(verbose) message(paste0("-> DSD ref identified in dataset = '", dsdRef, "'"))
        if(verbose) message("-> Attempt to fetch & bind DSD to dataset")
      }else{
        dsdRef <- flowRef
        if(verbose) message("-> No DSD ref associated to dataset")
        if(verbose) message("-> Attempt to fetch & bind DSD to dataset using 'flowRef'")
      }
    }
    
    #fetch DSD
    dsdObj <- NULL
    if(resource == "data"){
      dsdObj <- readSDMX(providerId = providerId, resource = "datastructure",
                       resourceId = dsdRef, verbose = verbose)
      if(is.null(dsdObj)){
        if(verbose) message(sprintf("-> Impossible to fetch DSD for dataset %s", flowRef))
      }else{
        if(verbose) message("-> DSD fetched and associated to dataset!")
        slot(obj, "dsd") <- dsdObj
      }
    }else if(resource == "dataflow"){
      dsdObj <- lapply(1:length(dsdRef), function(x){
        flowDsd <- readSDMX(providerId = providerId, resource = "datastructure",
                 resourceId = dsdRef[[x]], verbose = verbose)
        if(is.null(flowDsd)){
          if(verbose) message(sprintf("-> Impossible to fetch DSD for dataflow %s",resourceId))
        }else{
          if(verbose) message("-> DSD fetched and associated to dataflow!")
          slot(slot(obj,"dataflows")[[x]],"dsd") <<- flowDsd
        }
      })
    }
  }
  
  return(obj);
  
}

