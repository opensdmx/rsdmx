# test_Main_Helpers.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
# using helpers to build the SDMX request
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXHelpers")

#ECB
#---
test_that("ECB - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ECB", resource = "data",
                   flowRef = "DD", key = "M.SE.BSI_STF.RO.4F_N", key.mode = "SDMX",
                   start = 2010, end = 2010)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

test_that("ECB - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ECB", resource = "datastructure", resourceId = "ECB_DD1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#ESTAT (EUROSTAT)
#---------------
test_that("ESTAT - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ESTAT", resource = "data",
                   flowRef = "cdh_e_fos", key = list(NULL, NULL, "PC", "FOS1", "BE"),
                   start = 2005, end = 2010)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

test_that("ESTAT - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ESTAT", resource = "datastructure", resourceId = "DSD_nama_gdp_c")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#OECD
#----
test_that("OECD - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "OECD", resource = "data",
                   flowRef = "MIG", key = list("TOT", NULL, NULL), start = 2011, end = 2011)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

test_that("OECD - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "OECD", resource = "datastructure", resourceId = "TABLE1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#FAO (UN-FAO)
#------------
test_that("FAO - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "FAO", resource = "data",
                   flowRef = "CROP_PRODUCTION", key = list(NULL, "156", "5312", NULL, NULL),
                   start = "2010", end = "2014")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

test_that("FAO - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "FAO", resource = "datastructure", resourceId = "FAOSTAT")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#ILO (UN-ILO)
#------------
test_that("ILO - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ILO", resource = "data",
                   flowRef = "DF_CPI_FRA_CPI_TCPI_COI_RT", key = "ALL", key.mode = "SDMX",
                   start = "2010-01-01", end = "2014-12-31")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

test_that("ILO - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "ILO", resource = "datastructure", resourceId = "YI_ALB_EAP_TEAP_SEX_AGE_NB")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#UIS (UNESCO)
#------------
test_that("UIS - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "UIS", resource = "data",
                   flowRef = "EDULIT_DS", key = list("OFST_1_CP", NULL),
                   start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

test_that("UIS - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(agencyId = "UIS", resource = "datastructure", resourceId = "all")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

