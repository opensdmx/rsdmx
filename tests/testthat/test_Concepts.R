# test_Concepts.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Concepts methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXConcepts")

test_that("Concepts 2.0 - with Concepts (backward compatibility with 1.0)",{
  file <- system.file("extdata", "SDMXConcepts_Example_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  concepts <- SDMXConcepts(xmlObj, ns)
  expect_is(concepts, "SDMXConcepts")
  
  df <- as.data.frame(concepts)
  expect_is(df, "data.frame")
  expect_equal(colnames(df), c("id", "version","Name.en"))
  expect_equal(nrow(df), 15L)
})

test_that("Concepts - 2.0 - with ConceptSchemes",{
  file <- system.file("extdata", "SDMXConceptSchemes_Example_2.0.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  concepts <- SDMXConcepts(xmlObj, ns)
  expect_is(concepts, "SDMXConcepts")
  
  df <- as.data.frame(concepts)
  expect_is(df, "data.frame")
  expect_equal(colnames(df), c("id", "urn","Name.en"))
  expect_equal(nrow(df), 15L)
})

test_that("Concepts - 2.1 - with ConceptSchemes",{
  file <- system.file("extdata", "SDMXConceptSchemes_Example_2.1.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  concepts <- SDMXConcepts(xmlObj, ns)
  expect_is(concepts, "SDMXConcepts")
  
  df <- as.data.frame(concepts)
  expect_is(df, "data.frame")
  expect_equal(colnames(df), c("id", "urn","Name.en"))
  expect_equal(nrow(df), 15L)
})
