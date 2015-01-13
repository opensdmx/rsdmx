# E.Blondel - 2015/01/13
#=======================

SDMXUtilityData <- function(xmlObj){
  new("SDMXUtilityData",
      SDMX(xmlObj)
  )  	
}

#methods
#=======

as.data.frame.SDMXUtilityData <- function(x, ...){
  return(as.data.frame.SDMXCompactData(x))
}

setAs("SDMXUtilityData", "data.frame",
      function(from) as.data.frame.SDMXUtilityData(from));
