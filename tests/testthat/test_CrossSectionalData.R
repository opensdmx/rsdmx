# test_CrossSectionalData.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX CrossSectionalData methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXCrossSectionalData")

test_that("CrossSectionalData 1.0",{
  file <- system.file("extdata", "SDMXCrossSectionalDataExample_1.0.xml", package = "rsdmx")
  xmlObj <- xmlParse(file)
  
  ds <- SDMXCrossSectionalData(xmlObj)
  expect_is(ds, "SDMXCrossSectionalData")
  
  df <- as.data.frame(ds)
  expect_is(df, "data.frame")
})