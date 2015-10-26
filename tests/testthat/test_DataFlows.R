# test_DataFlows.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX DataFlows methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXDataFlows")

test_that("DataFlows - 2.1",{
  file <- system.file("extdata", "SDMXDataFlows_Example_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)  
  flow <- SDMXDataFlows(xmlObj)
  expect_is(flow, "SDMXDataFlows")
  expect_equal(length(flow@dataflows), 5L)
  
  flow.df <- as.data.frame(flow)
  expect_is(flow.df, "data.frame")
  expect_equal(nrow(flow.df), 5L)
  expect_equal(colnames(flow.df), c("id","agencyID",
                                    "Name.fr", "Name.en", "Name.es",
                                    "version", "uri", "urn", "isExternalReference",
                                    "isFinal", "validFrom", "validTo", "dsdRef"))
  expect_equal(flow.df[1,"id"], "DS-001")
  expect_equal(flow.df[1, "agencyID"], "MYORG")
  expect_equal(flow.df[1, "Name.en"], "Dataset 1")
  expect_equal(flow.df[1, "version"], "1.0")
  expect_equal(flow.df[1, "urn"], "urn:sdmx:org.sdmx.infomodel.datastructure.Dataflow=MYORG:DS-001(1.0)")
  expect_equal(flow.df[1, "dsdRef"], "DSD_DS-001")
})
