# test_Main.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMX")

file <- system.file("data", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
sdmxObj <- readSDMX(file, isURL = FALSE)

test_that("readSDMX - 2.0",{
	expect_is(sdmxObj, "SDMXGenericData")
})

test_that("as.XML - 2.0",{
	xml <- as.XML(sdmxObj)
	expect_is(xml, c("XMLInternalDocument", "XMLAbstractDocument", "oldClass"))
})

test_that("getSDMXSchema - 2.0",{
	schema <- getSDMXSchema(sdmxObj)
	expect_is(schema, "SDMXSchema")
})

test_that("getSDMXHeader - 2.0",{
	header <- getSDMXHeader(sdmxObj)
	expect_is(header, "SDMXHeader")
})

test_that("getSDMXType - 2.0",{
	type <- getSDMXType(sdmxObj)
	expect_is(type, "SDMXType")
})

#tests for 2.1
file2 <- system.file("data", "SDMXGenericDataExample_2.1.xml", package = "rsdmx")
sdmxObj2 <- readSDMX(file2, isURL = FALSE)

test_that("readSDMX - 2.1",{
  expect_is(sdmxObj2, "SDMXGenericData")
})

test_that("as.XML - 2.1",{
  xml <- as.XML(sdmxObj2)
  expect_is(xml, c("XMLInternalDocument", "XMLAbstractDocument", "oldClass"))
})

test_that("getSDMXSchema - 2.1",{
  schema <- getSDMXSchema(sdmxObj2)
  expect_is(schema, "SDMXSchema")
})

test_that("getSDMXHeader - 2.1",{
  header <- getSDMXHeader(sdmxObj2)
  expect_is(header, "SDMXHeader")
})

test_that("getSDMXType - 2.1",{
  type <- getSDMXType(sdmxObj2)
  expect_is(type, "SDMXType")
})