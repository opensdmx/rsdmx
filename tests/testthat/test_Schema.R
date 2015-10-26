# test_Schema.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Schema methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXSchema")

#read test data
file1 <- system.file("extdata", "SDMXMessageExample_2.0.xml", package = "rsdmx")
file2 <- system.file("extdata", "SDMXMessageExample_2.1.xml", package = "rsdmx")
xmlObj1 <- xmlParse(file1)
xmlObj2 <- xmlParse(file2)

test_that("version.SDMXSchema - 2.0",{
	schema1 = version.SDMXSchema(xmlObj1)
	expect_equal(schema1, "2.0")
})

test_that("version.SDMXSchema - 2.1",{
  schema2 = version.SDMXSchema(xmlObj2)
  expect_equal(schema2, "2.1")
})

test_that("SDMXSchema - 2.0",{
	obj1 = SDMXSchema(xmlObj1)
	expect_is(obj1, "SDMXSchema")
})

test_that("SDMXSchema - 2.1",{
  obj2 = SDMXSchema(xmlObj2)
  expect_is(obj2, "SDMXSchema")
})

test_that("getVersion - 2.0",{
	obj1 = SDMXSchema(xmlObj1)
	expect_equal(obj1@version, "2.0")
})

test_that("getVersion - 2.1",{
  obj2 = SDMXSchema(xmlObj2)
  expect_equal(obj2@version, "2.1")
})



