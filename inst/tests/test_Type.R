# test_Type.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Type
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXType")

#read test data
file1 <- system.file("data", "SDMXMessageExample_2.0.xml", package = "rsdmx")
file2 <- system.file("data", "SDMXMessageExample_2.1.xml", package = "rsdmx")
xmlObj1 <- xmlParse(file1)
xmlObj2 <- xmlParse(file2)

test_that("type.SDMXType - 2.0",{
	type1 <- type.SDMXType(xmlObj1)		
	expect_equal(type1, "GenericDataType")
})

test_that("type.SDMXType - 2.1",{
  type2 <- type.SDMXType(xmlObj2)		
  expect_equal(type2, "GenericDataType")
})

test_that("SDMXType - 2.0",{
	obj1 <- SDMXType(xmlObj1)
	expect_is(obj1, "SDMXType")
})

test_that("SDMXType - 2.1",{
  obj2 <- SDMXType(xmlObj2)
  expect_is(obj2, "SDMXType")
})

test_that("getType - 2.0",{
	obj1 <- SDMXType(xmlObj1)
	type1 <- getType(obj1)
	expect_equal(type1, "GenericDataType")
})

test_that("getType - 2.1",{
  obj2 <- SDMXType(xmlObj2)
  type2 <- getType(obj2)
  expect_equal(type2, "GenericDataType")
})
