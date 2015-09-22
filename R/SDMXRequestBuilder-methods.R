# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRequestBuilder <- function(baseUrl, suffix, handler){
  new("SDMXRequestBuilder", baseUrl = baseUrl, suffix = suffix, handler = handler)
}
