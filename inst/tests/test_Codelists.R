# test_Codelists.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Codelists methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXCodelists")

test_that("Codelists - 2.0",{
  file <- system.file("data", "SDMXCodelists_Example_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)  
  codelists <- SDMXCodelists(xmlObj)
  expect_is(codelists, "SDMXCodelists")
  expect_equal(length(codelists@codelists), 1L)
  
  #df <- as.data.frame(codelists)
  #expect_is(df, "data.frame")
})

test_that("Codelists - 2.1",{
  file <- system.file("data", "SDMXCodelists_Example_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)  
  codelists <- SDMXCodelists(xmlObj)
  expect_is(codelists, "SDMXCodelists")
  expect_equal(length(codelists@codelists), 1L)
  
  #df <- as.data.frame(codelists)
  #expect_is(df, "data.frame")
})