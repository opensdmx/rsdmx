# test_Main.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMX")

file <- system.file("data", "SDMXGenericDataExample.xml", package = "rsdmx")
sdmxObj <- readSDMX(file, isURL = FALSE)

test_that("readSDMX",{
	expect_is(sdmxObj, "SDMXDataSet")
})

test_that("as.XML",{
	xml <- as.XML(sdmxObj)
	expect_is(xml, c("XMLInternalDocument", "XMLAbstractDocument", "oldClass"))
})

test_that("getSDMXSchema",{
	schema <- getSDMXSchema(sdmxObj)
	expect_is(schema, "SDMXSchema")
})

test_that("getSDMXHeader",{
	header <- getSDMXHeader(sdmxObj)
	expect_is(header, "SDMXHeader")
})

test_that("getSDMXType",{
	type <- getSDMXType(sdmxObj)
	expect_is(type, "SDMXType")
})