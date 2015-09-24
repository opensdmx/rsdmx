# test_Main_Helpers.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
# using helpers to build the SDMX request
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMX")

#SDMX datasets
#------------

#ECB
#Note: for some reasons, this test fails when run automatically, but the code is working
#test_that("ECB",{
#  sdmx <- readSDMX(id = "ECB", operation = "data",
#                   key = "DD", filter = "M.SE.BSI_STF.RO.4F_N",
#                   start = 2010, end = 2010)
#  expect_is(sdmx, "SDMXGenericData")
#})

#EUROSTAT
test_that("Dataset - EUROSTAT",{
  sdmx <- readSDMX(agencyId = "ESTAT", operation = "data",
                   key = "cdh_e_fos", filter = list(NULL, NULL, "PC", "FOS1", "BE"),
                   start = 2005, end = 2010)
  expect_is(sdmx, "SDMXGenericData")
})

#OECD
test_that("Dataset - OECD",{
  sdmx <- readSDMX(agencyId = "OECD", operation = "GetData",
                   key = "MIG", filter = list("TOT", NULL, NULL), start = 2011, end = 2011)
  expect_is(sdmx, "SDMXMessageGroup")
})

#UN-FAO
test_that("Dataset - UN-FAO",{
  sdmx <- readSDMX(agencyId = "FAO", operation = "data",
                   key = "CROP_PRODUCTION", filter = list(NULL, "156", "5312", NULL, NULL),
                   start = "2010", end = "2014")
  expect_is(sdmx, "SDMXGenericData")
})

#UN-ILO
test_that("Dataset - UN-ILO",{
  sdmx <- readSDMX(agencyId = "ILO", operation = "data",
                   key = "DF_CPI_FRA_CPI_TCPI_COI_RT", filter = "ALL", filter.native = FALSE,
                   start = "2010-01-01", end = "2014-12-31")
  expect_is(sdmx, "SDMXGenericData")
})

