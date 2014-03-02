# test_Schema.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Schema methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXSchema")

#read test data
file <- system.file("data", "SDMXMessageExample.xml", package = "rsdmx")
xmlObj <- xmlParse(file)

test_that("version.SDMXSchema",{
	schema = version.SDMXSchema(xmlObj)
	expect_equal(schema, "2.0")
})

test_that("SDMXSchema",{
	obj = SDMXSchema(xmlObj)
	expect_is(obj, "SDMXSchema")
})

test_that("getVersion",{
	obj = SDMXSchema(xmlObj)
	schema = getVersion(obj)
	expect_equal(schema, "2.0")
})



