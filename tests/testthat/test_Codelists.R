# test_Codelists.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Codelists methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXCodelists")

test_that("Codelists - 2.0", {
  file <- system.file("extdata", "SDMXCodelists_Example_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  codelists <- SDMXCodelists(xmlObj, ns)
  expect_is(codelists, "SDMXCodelists")
  expect_equal(length(codelists@codelists), 1L)

  df <- as.data.frame(codelists)
  expect_is(df, "data.frame")
})

test_that("Codelists - 2.1", {
  file <- system.file("extdata", "SDMXCodelists_Example_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  codelists <- SDMXCodelists(xmlObj, ns)
  expect_is(codelists, "SDMXCodelists")
  expect_equal(length(codelists@codelists), 1L)

  df <- as.data.frame(codelists)
  expect_is(df, "data.frame")
})

test_that("Hierarchical codelists", {
  file <- system.file("extdata", "SDMXCodelists_Example_hierarchical_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  codelists <- SDMXCodelists(xmlObj, ns)
  expect_is(codelists, "SDMXCodelists")
  expect_equal(length(codelists@codelists), 1L)

  # expect to read the right parentCode from the XML object when there is
  expect_equal(codelists@codelists[[1]]@Code[[5]]@parentCode, "POL")
  # expect to find an NA in parentCode when there is no parentCode in the XML object
  expect_true(is.na(codelists@codelists[[1]]@Code[[1]]@parentCode))

  df <- as.data.frame(codelists)
  expect_is(df, "data.frame")
})