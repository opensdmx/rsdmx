# test_GenericData.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX GenericData methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXGenericData")

test_that("GenericData 2.0",{
  file <- system.file("data", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
	ds <- SDMXGenericData(xmlObj)
	expect_is(ds, "SDMXGenericData")
	
	df <- as.data.frame(ds)
	expect_is(df, "data.frame")
	expect_equal(c(paste(rep("C",5),1:5,sep=""), "obsTime", "obsValue"), names(df))
  
  #test absence data
  expect_true(is.na(df[nrow(df),]$obsValue))
  expect_true(is.na(df[nrow(df),]$obsTime))
})

test_that("GenericData - 2.0 - Eurostat",{
  file <- system.file("data", "Example_Eurostat_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXGenericData(xmlObj)
  expect_is(ds, "SDMXGenericData")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  # test df content
  expect_equal(df, structure(list(UNIT = c("PC", "PC"), REASON = c("ECO", "ECO"), 
                                  ENTERPR = c("OTH", "YHE"), NACE_R2 = c("B-E", "M"), 
                                  GEO = c("PL", "PL"), FREQ = c("A", "A"), 
                                  obsTime = rep("2009",2), 
                                  obsValue = c(16.8, 18)), .Names = c("UNIT", "REASON", "ENTERPR", "NACE_R2", "GEO", "FREQ", "obsTime", "obsValue"), class = "data.frame",
                             row.names = 1:2))
  
})

test_that("GenericData - 2.1",{
  file <- system.file("data", "SDMXGenericDataExample_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXGenericData(xmlObj)
  expect_is(ds, "SDMXGenericData")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  # test df content
  expect_true(all(df == structure(list(UNIT = rep("PC",4),
                                  Y_GRAD = c(rep("TOTAL",2),rep("Y_GE1990",2)), 
                                  FOS07 = rep("FOS1",4),
                                  GEO = rep("BE",4),
                                  FREQ = rep("A",4),
                                  obsTime = rep(c("2009","2006"),2),
                                  obsValue = c(NA, NA,43.75,NA),
                                  OBS_STATUS = rep("na",4)),
                                  .Names = c("UNIT", "Y_GRAD","FOS07", "GE0",
                                             "FREQ", "obsTime", "obsValue"),
                                  class = "data.frame",
                                  row.names = 1:4), na.rm = TRUE))
 
})
