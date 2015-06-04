# test_SOAP.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX SOAP responses
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXSoapResponse")

test_that("SOAP - CompactData",{
  file <- system.file("extdata", "SDMX_SOAP_Example.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)

  expect_true(isSoapRequestEnvelope(xmlObj))
  xmlObj <- getSoapRequestResult(xmlObj)
  expect_false(isSoapRequestEnvelope(xmlObj))
  
  ds <- SDMXCompactData(xmlObj)
  expect_is(ds, "SDMXCompactData")
})