# test_Main.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMX")

#SDMX datasets
#------------

file <- system.file("extdata", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
sdmxObj <- readSDMX(file, isURL = FALSE)

test_that("readSDMX - 2.0",{
	expect_is(sdmxObj, "SDMXGenericData")
})

#tests for 2.1
file2 <- system.file("extdata", "SDMXGenericDataExample_2.1.xml", package = "rsdmx")
sdmxObj2 <- readSDMX(file2, isURL = FALSE)

test_that("readSDMX - 2.1",{
  expect_is(sdmxObj2, "SDMXGenericData")
})

#SDMXConcepts
#-----------
test_that("readSDMX - SDMXConcepts - 2.0",{
  file <- system.file("extdata", "SDMXConcepts_Example_2.0.xml",
                      package = "rsdmx")
  sdmxObj <- readSDMX(file, isURL = FALSE)
  expect_is(sdmxObj, "SDMXConcepts")
})

test_that("readSDMX - SDMXConcepts (conceptScheme) - 2.0",{
  file <- system.file("extdata", "SDMXConceptSchemes_Example_2.0.xml",
                       package = "rsdmx")
  sdmxObj <- readSDMX(file, isURL = FALSE)
  expect_is(sdmxObj, "SDMXConcepts")
})

test_that("readSDMX - SDMXConcepts (conceptScheme) - 2.1",{
  file <- system.file("extdata", "SDMXConceptSchemes_Example_2.1.xml",
                      package = "rsdmx")
  sdmxObj <- readSDMX(file, isURL = FALSE)
  expect_is(sdmxObj, "SDMXConcepts")
})

#SDMXCodelists
#-------------
test_that("readSDMX - SDMXCodelists - 2.0",{
  file <- system.file("extdata", "SDMXCodelists_Example_2.0.xml",
                      package = "rsdmx")
  sdmxObj <- readSDMX(file, isURL = FALSE)
  expect_is(sdmxObj, "SDMXCodelists")
})

test_that("readSDMX - SDMXCodelists - 2.0",{
  file <- system.file("extdata", "SDMXCodelists_Example_2.1.xml",
                      package = "rsdmx")
  sdmxObj <- readSDMX(file, isURL = FALSE)
  expect_is(sdmxObj, "SDMXCodelists")
})

#SDMXDataStructureDefinition (DSD)
#--------------------------------
test_that("readSDMX - SDMXDataStructureDefinition (DSD) - 2.0",{

  file <- system.file("extdata", "SDMXDataStructureDefinition_Example_2.0.xml",
                      package = "rsdmx")
  dsd <- readSDMX(file, isURL = FALSE)
  expect_is(dsd, "SDMXDataStructureDefinition")
  expect_is(dsd@concepts, "SDMXConcepts")
  expect_is(dsd@codelists, "SDMXCodelists")
  expect_is(dsd@datastructures, "SDMXDataStructures")
})
