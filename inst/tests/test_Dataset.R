# test_Dataset.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Dataset methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXDataSet")

test_that("GenericData",{
  file <- system.file("data", "SDMXGenericDataExample.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
	ds <- SDMXDataSet(xmlObj)
	expect_is(ds, "SDMXDataSet")
	
	df <- as.data.frame(ds)
	expect_is(df, "data.frame")
	expect_equal(c(paste(rep("C",5),1:5,sep=""), "obsTime", "obsValue"), names(df))
})

test_that("CompactData",{
  file <- system.file("data", "SDMXCompactDataExample.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXDataSet(xmlObj)
  expect_is(ds, "SDMXDataSet")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
})