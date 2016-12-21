# test_saveSDMX.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX save methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("saveSDMX")

test_that("saveSDMX",{
  file <- system.file("extdata", "SDMXCodelists_Example_2.0.xml", package = "rsdmx")
  sdmx <- readSDMX(file, isURL = FALSE)
  sdmx.copy <- sdmx
  saveSDMX(sdmx.copy, "tmp.RData")
  rm(sdmx.copy)
  sdmx.copy <- readSDMX("tmp.RData", isRData = TRUE)
  
  for(slotName in slotNames(sdmx)){
    if(slotName == "xmlObj"){
      expect_true(all(sapply(XML::compareXMLDocs(sdmx@xmlObj, sdmx.copy@xmlObj), length) == 0))
    }else{
      expect_true(identical(slot(sdmx,slotName), slot(sdmx.copy,slotName)))
    }
  }
  
})