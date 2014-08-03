# test_CompactData.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX CompactData methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXCompactData")

test_that("CompactData 2.0",{
  file <- system.file("data", "SDMXCompactDataExample_2.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXCompactData(xmlObj)
  expect_is(ds, "SDMXCompactData")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
  
  #test absence data
  expect_true(is.na(df[nrow(df),]$YEA))
  expect_true(is.na(df[nrow(df),]$OBS_VALUE))
  expect_true(is.na(df[nrow(df)-1,]$YEA))
  expect_true(is.na(df[nrow(df)-1,]$OBS_VALUE))
})