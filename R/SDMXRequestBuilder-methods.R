# E.Blondel - 2015/09/22
#========================

#constructor
SDMXRequestBuilder <- function(regUrl, repoUrl, handler, compliant){
  new("SDMXRequestBuilder",
      regUrl = regUrl, repoUrl = repoUrl,
      handler = handler, compliant = compliant)
}
