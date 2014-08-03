# test_Namespaces.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for Namespace functions
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("Namespaces")

test_that("getNamespaces",{
  file <- system.file("data", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
  sdmx <- readSDMX(file, isURL = FALSE)
  
  namespaces <- getNamespaces(sdmx)
  expect_is(namespaces, "data.frame")
  expect_equal(c("id","uri"), colnames(namespaces))
  expect_equal(12L, nrow(namespaces))
})

test_that("findNamespace",{
  file <- system.file("data", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
  sdmx <- readSDMX(file, isURL = FALSE)
  
  namespaces <- getNamespaces(sdmx)
  namespace <- findNamespace(namespaces, "generic")
  expect_is(namespace, "character")
  expect_equal(1L, length(namespace))
  expect_equal("http://www.SDMX.org/resources/SDMXML/schemas/v2_0/generic",
               as.character(namespace))
  
})

