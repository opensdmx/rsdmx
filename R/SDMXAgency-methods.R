#' @name SDMXAgency
#' @rdname SDMXAgency
#' @aliases SDMXAgency,SDMXAgency-method
#' 
#' @usage
#' SDMXAgency(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXAgency"
#' 
#' @seealso \link{readSDMX}
#'
SDMXAgency <- function(xmlObj, namespaces){
  obj <- organisation.SDMXOrganisation(xmlObj, namespaces, "SDMXAgency")
}