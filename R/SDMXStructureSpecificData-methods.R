# E.Blondel - 2015/01/13
#=======================

SDMXStructureSpecificData <- function(xmlObj){
  new("SDMXStructureSpecificData",
      SDMX(xmlObj)
  )    
}

#methods
#=======

as.data.frame.SDMXStructureSpecificData <- function(x, ...){
  return(as.data.frame.SDMXAllCompactData(x, "structurespecific"));
}

setAs("SDMXStructureSpecificData", "data.frame",
      function(from) as.data.frame.SDMXStructureSpecificData(from));
