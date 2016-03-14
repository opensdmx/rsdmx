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
  ns <- namespaces.SDMX(xmlObj)
  expect_true(isSoapRequestEnvelope(xmlObj, ns))
  xmlObj <- getSoapRequestResult(xmlObj)
  expect_false(isSoapRequestEnvelope(xmlObj, ns))
  
  ds <- SDMXCompactData(xmlObj, ns)
  expect_is(ds, "SDMXCompactData")
})