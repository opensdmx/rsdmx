# test_DataStructures.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX DataStructures methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXDataStructures")

test_that("DataStructures / KeyFamilies - 2.0",{
  file <- system.file("extdata", "SDMXDataStructures_Example_2.0.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)  
  ds <- SDMXDataStructures(xmlObj)
  expect_is(ds, "SDMXDataStructures")
  expect_equal(length(ds@datastructures), 1L)
  
  ds.df <- as.data.frame(ds)
  expect_is(ds.df, "data.frame")
  expect_equal(nrow(ds.df), 1L)
  expect_equal(colnames(ds.df), c("id","agencyID","Name.en", "version",
                               "uri", "urn", "isExternalReference", "isFinal",
                               "validFrom", "validTo"))
  
  expect_equal(ds.df[1,"id"], "TRADE_DATASTRUCTURE")
  expect_equal(ds.df[1, "agencyID"], "FAO")
  expect_equal(ds.df[1, "Name.en"], "TRADE_DATASTRUCTURE")
  expect_equal(ds.df[1, "version"], "0.1")
  expect_equal(ds.df[1, "urn"], "urn:sdmx:org.sdmx.infomodel.DataStructure=FAO:TRADE_DATASTRUCTURE[0.1]")

})

test_that("DataStructures / KeyFamilies - 2.1",{
  file <- system.file("extdata", "SDMXDataStructures_Example_2.1.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)  
  ds <- SDMXDataStructures(xmlObj)
  expect_is(ds, "SDMXDataStructures")
  expect_equal(length(ds@datastructures), 1L)
  
  ds.df <- as.data.frame(ds)
  expect_is(ds.df, "data.frame")
  expect_equal(nrow(ds.df), 1L)
  expect_equal(colnames(ds.df), c("id","agencyID","Name.en", "version",
                                "uri", "urn, isExternalReference", "isFinal",
                                "validFrom", "validTo"))
  expect_equal(ds.df[1,"id"], "ECB_EXR1")
  expect_equal(ds.df[1, "agencyID"], "ECB")
  expect_equal(ds.df[1, "Name.en"], "Exchange Rates")
  expect_equal(ds.df[1, "version"], "1.0")
  expect_equal(ds.df[1, "urn"], "urn:sdmx:org.sdmx.infomodel.datastructure.DataStructure=ECB:ECB_EXR1(1.0)")
  
})
