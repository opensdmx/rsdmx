# test_Dataset.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Dataset methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
require(XML)
context("SDMXDataSet")

test_that("GenericData",{
  file <- system.file("data", "SDMXGenericDataExample.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
	ds <- SDMXDataSet(xmlObj)
	expect_is(ds, "SDMXDataSet")
	
	df <- as.data.frame(ds)
	expect_is(df, "data.frame")
	expect_equal(c(paste(rep("C",5),1:5,sep=""), "obsTime", "obsValue"), names(df))
  
  #test absence data
  expect_true(is.na(df[nrow(df),]$obsValue))
  expect_true(is.na(df[nrow(df),]$obsTime))
})

test_that("CompactData",{
  file <- system.file("data", "SDMXCompactDataExample.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXDataSet(xmlObj)
  expect_is(ds, "SDMXDataSet")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  #test absence data
  expect_true(is.na(df[nrow(df),]$YEA))
  expect_true(is.na(df[nrow(df),]$OBS_VALUE))
  expect_true(is.na(df[nrow(df)-1,]$YEA))
  expect_true(is.na(df[nrow(df)-1,]$OBS_VALUE))
})

test_that("GenericData_Eurostat",{
  file <- system.file("data", "SDMXGenericDataExample_Eurostat.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXDataSet(xmlObj)
  expect_is(ds, "SDMXDataSet")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  # test df content
  expect_equal(df, structure(list(UNIT = c("PC", "PC"), REASON = c("ECO", "ECO"), 
                                  ENTERPR = c("OTH", "YHE"), NACE_R2 = c("B-E", "M"), 
                                  GEO = c("PL", "PL"), FREQ = c("A", "A"), 
                                  obsTime = structure(c(1L, 1L), .Label = "2009", 
                                                      class = "factor"), 
                                  obsValue = c(16.8, 18)), .Names = c("UNIT", "REASON", "ENTERPR", "NACE_R2", "GEO", "FREQ", "obsTime", "obsValue"), class = "data.frame",
                             row.names = 1:2))
  
  
})