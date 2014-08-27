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

})
