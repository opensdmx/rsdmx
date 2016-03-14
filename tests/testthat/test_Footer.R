# test_Footer.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Footer methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXFooter")

test_that("SDMXFooter - 2.0",{
  file <- system.file("extdata", "SDMXMessageExample_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  obj = SDMXFooter(xmlObj, ns)
  
  expect_is(obj, "SDMXFooter")
  expect_equal(length(obj@messages),0)
})

test_that("SDMXFooter - 2.1",{
  file <- system.file("extdata", "SDMXMessageExample_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  obj = SDMXFooter(xmlObj, ns)
  
  expect_is(obj, "SDMXFooter")
  
  obj.messages = obj@messages
  expect_equal(length(obj@messages),2)
  
  obj1 = obj.messages[[1]]
  expect_is(obj1, "SDMXFooterMessage")
  expect_equal(obj1@code, "413")
  expect_equal(obj1@severity, "Information")
  obj1.messages = obj1@messages
  expect_equal(length(obj1.messages),3)
  expect_equal(obj1.messages[[1]], "info message 1")
  expect_equal(obj1.messages[[2]], "info message 2")
  expect_equal(obj1.messages[[3]], "info message 3")
  
  obj2 = obj.messages[[2]]
  expect_is(obj2, "SDMXFooterMessage")
  expect_equal(obj2@code, "413")
  expect_equal(obj2@severity, "Warning")
  obj2.messages = obj2@messages
  expect_equal(length(obj2.messages),2)
  expect_equal(obj2.messages[[1]], "warning message 1")
  expect_equal(obj2.messages[[2]], "warning message 2")
  
})