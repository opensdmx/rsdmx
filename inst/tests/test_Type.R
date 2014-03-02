# test_Type.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Type
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXType")

#read test data
file <- system.file("data", "SDMXMessageExample.xml", package = "rsdmx")
xmlObj <- xmlParse(file)

test_that("type.SDMXType",{
	type <- type.SDMXType(xmlObj)		
	expect_equal(type, "SDMXGenericData")
})

test_that("SDMXType",{
	obj <- SDMXType(xmlObj)
	expect_is(obj, "SDMXType")
})

test_that("getType",{
	obj <- SDMXType(xmlObj)
	type <- getType(obj)
	expect_equal(type, "SDMXGenericData")
})
