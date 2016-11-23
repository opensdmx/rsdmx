# test_Main_Helpers.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Main methods
# using helpers to build the SDMX request
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXHelpers")

#testing main helpers arguments

#-> dataflow
test_that("Main helpers arguments",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  #existing provider
  providerId1 <- "IMF"
  provider1 <- findSDMXServiceProvider(providerId1)
  sdmx <- readSDMX(provider = provider1, resource = "dataflow")
  expect_false(is.null(sdmx))
  expect_is(sdmx, "SDMXDataFlows")
  sdmx <- readSDMX(providerId = providerId1, resource = "dataflow")
  expect_false(is.null(sdmx))
  expect_is(sdmx, "SDMXDataFlows")
  
  #wrong provider
  providerId2 <- "IMF!"
  provider2 <- findSDMXServiceProvider(providerId2)
  expect_error(readSDMX(provider = provider2, resource = "dataflow"), "Provider should be an instance of 'SDMXServiceProvider'")
  expect_error(readSDMX(providerId = providerId2, resource = "dataflow"), "No provider with identifier IMF!")
  
  #wrong request
  expect_error(readSDMX(providerId = "KNOEMA", resource = "data", flowRef = "SADG2015-WRONG"),
               "HTTP request failed with status: 400 Dataset not found.")
  
})

#international data providers

#ECB
#---

#-> dataflow
test_that("ECB - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("ECB - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "datastructure", resourceId = "ECB_DD1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ECB - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "data",
                   flowRef = "DD", key = "M.SE.BSI_STF.RO.4F_N", key.mode = "SDMX",
                   start = 2010, end = 2010)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ESTAT (EUROSTAT)
#---------------

#-> dataflow
test_that("ESTAT - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("ESTAT - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "datastructure", resourceId = "DSD_nama_gdp_c")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ESTAT - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "data",
                   flowRef = "cdh_e_fos", key = list(NULL, NULL, "PC", "FOS1", "BE"),
                   start = 2005, end = 2010)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#IMF
#---

#-> dataflow
test_that("IMF - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "IMF", resource = "dataflow", agencyId = "IMF")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("IMF - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "IMF", resource = "datastructure", resourceId = "BOP")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("IMF - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "IMF", resource = "data",
                   flowRef = "BOP_GBPM6", start = 2010, end = 2015) 
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})

#OECD
#----

#-> dataflow
test_that("OECD - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("OECD - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "datastructure", resourceId = "TABLE1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("OECD - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "data",
                   flowRef = "MIG", key = list("TOT", NULL, NULL), start = 2011, end = 2011)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

#UNSD (UN-DATA)
#----

#-> dataflow
test_that("UNSD - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("UNSD - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "datastructure", resourceId = "CountryData")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("UNSD - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "data",
                   flowRef = "DF_UNDATA_COUNTRYDATA", key = NULL,
                   start = 2011, end = 2011)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#FAO (UN-FAO)
#------------

#-> datastructure
test_that("FAO - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "FAO", resource = "datastructure", resourceId = "FAOSTAT")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("FAO - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "FAO", resource = "data",
                   flowRef = "CROP_PRODUCTION", key = list(NULL, "156", "5312", NULL, NULL),
                   start = "2010", end = "2014")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ILO (UN-ILO)
#------------

#-> datastructure
test_that("ILO - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO", resource = "datastructure", resourceId = "YI_ALB_EAP_TEAP_SEX_AGE_NB")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ILO - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO", resource = "data",
                   flowRef = "DF_CPI_FRA_CPI_TCPI_COI_RT", key = "ALL", key.mode = "SDMX",
                   start = "2010-01-01", end = "2014-12-31")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#UIS (UNESCO)
#------------

#-> dataflow
test_that("UIS - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UIS", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("UIS - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UIS", resource = "datastructure", resourceId = "EDULIT_DS")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("UIS - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UIS", resource = "data",
                   flowRef = "EDULIT_DS", key = list("OFST_1_CP", NULL),
                   start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

#WBG_WITS
#--------

#-> dataflow
test_that("WBG_WITS - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("WBG_WITS - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "datastructure", resourceId = "TARIFF_TRAINS")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("WBG_WITS - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "data",
                   key = ".840.000.020110.reported", key.mode = "SDMX",
                   flowRef = "DF_WITS_Tariff_TRAINS", start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#national data providers

#ABS (Australia)
#-------------

#-> datastructure
test_that("ABS - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ABS", resource = "datastructure", resourceId = "ALC")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ABS - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ABS", resource = "data",
                   flowRef = "ALC", key = "1.1+2.1+2+3+5+4.6+10+11+12+15+14.A", key.mode = "SDMX",
                   start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

#NBB (Belgium)
#-------------

#-> datastructure
test_that("NBB - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NBB", resource = "datastructure", resourceId = "QNA")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("NBB - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NBB", resource = "data",
                   flowRef = "QNA", key = "all", key.mode = "SDMX",
                   start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

#INSEE (France)
#-------------

#-> dataflow
test_that("INSEE - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("INSEE - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "datastructure", resourceId = "IPI-2010-A21")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("INSEE - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "data",
                   flowRef = "IPI-2010-A21", key = "all", key.mode = "SDMX",
                   start = 2010, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})

#INEGI (MEXICO)
#-------------

#-> dataflow
test_that("INEGI - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("INEGI - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "datastructure", resourceId = "NAWWE")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("INEGI - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "data",
                   flowRef = "DF_PIB_PB2008", start = 2010, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ISTAT (ITALY)
#-------------

#-> dataflow
test_that("ISTAT - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
#TODO investigate issue with xmlNamespaceDefinitions (XML)
test_that("ISTAT - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "datastructure", resourceId = "DCCV_CONSACQUA")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ISTAT - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "data",
                   flowRef = "12_60", start = 2015, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#other data providers

#KNOEMA
#------

#-> dataflow
test_that("KNOEMA - dataflow",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "KNOEMA", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("KNOEMA - datastructure",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "KNOEMA", resource = "datastructure", resourceId = "SADG2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("KNOEMA - data",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "KNOEMA", resource = "data", flowRef = "SADG2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})
