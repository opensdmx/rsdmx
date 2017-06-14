#' @name SDMXOrganisationSchemes
#' @rdname SDMXOrganisationSchemes
#' @aliases SDMXOrganisationSchemes,SDMXOrganisationSchemes-method
#' 
#' @usage
#' SDMXOrganisationSchemes(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "OrganisationSchemes"
#' 
#' @seealso \link{readSDMX}
#'
SDMXOrganisationSchemes <- function(xmlObj, namespaces){
  new("SDMXOrganisationSchemes",
      SDMX(xmlObj, namespaces),
      organisationSchemes = organisationSchemes.SDMXOrganisationSchemes(xmlObj, namespaces)
  )
}

#get list of SDMXOrganisationScheme (SDMXAgencyScheme)
#================================================
organisationSchemes.SDMXOrganisationSchemes <- function(xmlObj, namespaces){
  
  agSchemes <- list()
  
  sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
  VERSION.21 <- sdmxVersion == "2.1"

  messageNsString <- "message"
  if(isRegistryInterfaceEnvelope(xmlObj, FALSE)) messageNsString <- "registry"
  messageNs <- findNamespace(namespaces, messageNsString)
  strNs <- findNamespace(namespaces, "structure")
  
  #agencyScheme
  if(VERSION.21){
    agXML <- getNodeSet(xmlObj,"//mes:Structures/str:OrganisationSchemes/str:AgencyScheme",
                        namespaces = c(mes = as.character(messageNs), str = as.character(strNs)))
    agSchemes <- lapply(agXML, SDMXAgencyScheme, namespaces)
  }
  
  return(agSchemes)
}

#methods
as.data.frame.SDMXOrganisationSchemes <- function(x, ...){
  
  out <- do.call("rbind.fill",
                 lapply(x@organisationSchemes,
                        function(as){
                          #TODO implement as.data.frame
                          asf <- data.frame(
                            id = slot(as, "id"),
                            agencyID = slot(as, "agencyID"),
                            version = slot(as, "version"),
                            uri = slot(as, "uri"),
                            urn = slot(as, "urn"),
                            isExternalReference = slot(as, "isExternalReference"),
                            isFinal = slot(as, "isFinal"),
                            validFrom = slot(as, "validFrom"),
                            validTo = slot(as, "validTo"),
                            stringsAsFactors = FALSE
                          )
                          return(asf)
                        })
  )
  return(encodeSDMXOutput(out))
  
}

setAs("SDMXOrganisationSchemes", "data.frame",
      function(from) as.data.frame.SDMXOrganisationSchemes(from))