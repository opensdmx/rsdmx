# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRequestBuilder <- function(baseUrl, handler, compliant){
  new("SDMXRequestBuilder", baseUrl = baseUrl, handler = handler, compliant = compliant)
}
