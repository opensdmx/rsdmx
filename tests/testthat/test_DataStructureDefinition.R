# test_DataStructureDefinition.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX DataStructureDefinition (DSD) methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXDataStructureDefinition")

test_that("DataStructureDefinition (DSD) - 2.0",{
  file <- system.file("extdata", "SDMXDataStructureDefinition_Example_2.0.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)  
  dsd <- SDMXDataStructureDefinition(xmlObj)
  expect_is(dsd, "SDMXDataStructureDefinition")
  expect_is(dsd@concepts, "SDMXConcepts")
  expect_is(dsd@codelists, "SDMXCodelists")
  expect_is(dsd@datastructures, "SDMXDataStructures")
})

test_that("DataStructureDefinition (DSD) - 2.1",{
  file <- system.file("extdata", "SDMXDataStructureDefinition_Example_2.1.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)  
  dsd <- SDMXDataStructureDefinition(xmlObj)
  expect_is(dsd, "SDMXDataStructureDefinition")
  expect_is(dsd@concepts, "SDMXConcepts")
  expect_is(dsd@codelists, "SDMXCodelists")
  expect_is(dsd@datastructures, "SDMXDataStructures")
})

