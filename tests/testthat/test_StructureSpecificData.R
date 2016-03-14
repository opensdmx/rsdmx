# test_StructureSpecificData.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX StructureSpecificData methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXStructureSpecificData")

test_that("StructureSpecificData 2.1",{
  file <- system.file("extdata", "SDMXStructureSpecificDataExample_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  ds <- SDMXStructureSpecificData(xmlObj, ns)
  expect_is(ds, "SDMXStructureSpecificData")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  expect_false(is.null(df))
  expect_true(nrow(df) > 0)

})