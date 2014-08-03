# E.Blondel - 2014/08/03
#=======================

SDMXMessageGroup <- function(xmlObj){
  new("SDMXMessageGroup",
      SDMX(xmlObj)
  )		
}

#methods
as.data.frame.SDMXMessageGroup <- function(x, ...){
  #TODO support for other included message types (at now limited to SDMXGenericData for making it work with OECD)
  dataset <- as.data.frame.SDMXGenericData(x) 
  return(dataset)
}

setAs("SDMXGenericData", "data.frame",
      function(from) as.data.frame.SDMXMessague(from));
