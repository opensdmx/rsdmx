# test_Dataset.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Dataset methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXDataSet")

test_that("GenericData 2.0",{
  file <- system.file("data", "SDMXGenericDataExample_2.0.xml", package = "rsdmx")
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

test_that("CompactData 2.0",{
  file <- system.file("data", "SDMXCompactDataExample_2.0.xml", package = "rsdmx")
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

test_that("GenericData - 2.0 - Eurostat",{
  file <- system.file("data", "Example_Eurostat_2.0.xml", package = "rsdmx")
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

test_that("GenericData - 2.1",{
  file <- system.file("data", "SDMXGenericDataExample_2.1.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXDataSet(xmlObj)
  expect_is(ds, "SDMXDataSet")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  # test df content
  expect_true(all(df == structure(list(UNIT = rep("PC",4),
                                  Y_GRAD = c(rep("TOTAL",2),rep("Y_GE1990",2)), 
                                  FOS07 = rep("FOS1",4),
                                  GEO = rep("BE",4),
                                  FREQ = rep("A",4),
                                  obsTime = structure(
                                    rep(c(1L, 2L),2),
                                    .Label = c("2009","2006"),class = "factor"),
                                  obsValue = c(NA, NA,43.75,NA)),
                                  .Names = c("UNIT", "Y_GRAD","FOS07", "GE0",
                                             "FREQ", "obsTime", "obsValue"),
                                  class = "data.frame",
                                  row.names = 1:4), na.rm = TRUE))
 
})
