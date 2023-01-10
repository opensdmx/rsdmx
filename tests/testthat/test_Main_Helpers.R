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
               "HTTP request failed with status: 400 ")
  
})

#international data providers

#BIS
#---

#-> dataflow
test_that("BIS - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BIS", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
    expect_is(as.data.frame(sdmx), "data.frame")
  }
})

#-> datastructure
test_that("BIS - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BIS", resource = "datastructure", resourceId = "BIS_XR")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("BIS - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BIS", resource = "data",
                   flowRef = "WS_XRU", key.mode = "SDMX",
                   start = 2020, end = 2020)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})

#ECB
#---

#-> dataflow
test_that("ECB - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("ECB - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "datastructure", resourceId = "ECB_EST1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ECB - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ECB", resource = "data",
                   flowRef = "DD", key = "all", key.mode = "SDMX",
                   start = 2020, end = 2020)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ESTAT (EUROSTAT)
#---------------

#-> dataflow
test_that("ESTAT - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("ESTAT - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "datastructure", resourceId = "DSD_tec00118")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ESTAT - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ESTAT", resource = "data",
                   flowRef = "tec00118", key = "all",
                   start = 2020, end = 2020)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#IMF
#---

#-> dataflow
test_that("IMF - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "IMF", resource = "dataflow", agencyId = "IMF")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("IMF - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "IMF", resource = "datastructure", resourceId = "BOP")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("IMF - data",{
  testthat::skip_on_cran()
  #TODO to test, sounds it's not public anymore
  #sdmx <- readSDMX(providerId = "IMF", resource = "data", flowRef = "BOP_GBPM6", start = 2020, end = 2020) 
  #if(!is.null(sdmx)){
  #  expect_is(sdmx, "SDMXStructureSpecificData")
  #}
})

#OECD
#----

#-> dataflow
test_that("OECD - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("OECD - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "datastructure", resourceId = "TABLE1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("OECD - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "OECD", resource = "data",
                   flowRef = "MIG", key = list("TOT", NULL, NULL), start = 2011, end = 2011)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})

#UNICEF
#----

#-> dataflow
test_that("UNICEF - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNICEF", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("UNICEF - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNICEF", resource = "datastructure", resourceId = "COVID")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("UNICEF - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNICEF", resource = "data",
                   flowRef = "COVID", key = NULL)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})



#CD2030
#----

#-> dataflow
test_that("CD2030 - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "CD2030", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("CD2030 - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "CD2030", resource = "datastructure", resourceId = "CDDEM")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("CD2030 - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "CD2030", resource = "data",
                   flowRef = "CDDEM", key = NULL)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})


#UNSD (UN-DATA)
#----

#-> dataflow
test_that("UNSD - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("UNSD - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "datastructure", resourceId = "CountryData")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("UNSD - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "UNSD", resource = "data",
                   flowRef = "DF_UNDATA_COUNTRYDATA", key = NULL,
                   start = 2011, end = 2011)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})


#ILO_Legacy (UN-ILO)
#------------

#-> datastructure
test_that("ILO - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO_Legacy", resource = "datastructure", resourceId = "YI_ALB_EAP_TEAP_SEX_AGE_NB")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ILO - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO_Legacy", resource = "data",
                   flowRef = "DF_CPI_FRA_CPI_TCPI_COI_RT", key = "ALL", key.mode = "SDMX",
                   start = "2010-01-01", end = "2014-12-31")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ILO (UN-ILO)
#------------

#-> dataflow
test_that("ILO - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("ILO - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO", resource = "datastructure", resourceId = "DF_CLD_TPOP_SEX_AGE_GEO_NB")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ILO - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ILO", resource = "data",
                   flowRef = "DF_CLD_TPOP_SEX_AGE_GEO_NB", key = "ALL", key.mode = "SDMX",
                   start = "2020-01-01", end = "2020-12-31")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#WBG_WITS
#--------

#-> dataflow
test_that("WBG_WITS - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("WBG_WITS - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "datastructure", resourceId = "TARIFF_TRAINS")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("WBG_WITS - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WBG_WITS", resource = "data",
                   key = ".840.000.020110.reported", key.mode = "SDMX",
                   flowRef = "DF_WITS_Tariff_TRAINS", start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#WB (World Bank)
#--------

#-> dataflow
test_that("WB - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WB", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("WB - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WB", resource = "datastructure", resourceId = "WDI")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("WB - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "WB", resource = "data",
                   key = "A.SP_POP_TOTL.AFG", key.mode = "SDMX",
                   flowRef = "WDI", start = "2011", end = "2011")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#PDH (Pacific Data Hub)
#--------

#-> dataflow
test_that("PDH - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "PDH", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("PDH - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "PDH", resource = "datastructure", resourceId = "DSD_CPI")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("PDH - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "PDH", resource = "data",
                   key = "A.FJ.INF.", key.mode = "SDMX",
                   flowRef = "DF_CPI", start = "2015", end = "2019")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#national data providers

#ABS (Australia)
#-------------

#-> datastructure
test_that("ABS - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ABS", resource = "datastructure", resourceId = "ALC")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ABS - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ABS", resource = "data",
                   flowRef = "ALC", key = "1.1+2.1+2+3+5+4.6+10+11+12+15+14.A", key.mode = "SDMX",
                   start = "2000", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#NBB (Belgium)
#-------------

#-> datastructure
test_that("NBB - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NBB", resource = "datastructure", resourceId = "QNA")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("NBB - data",{
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
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("INSEE - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "datastructure", resourceId = "CONSO-MENAGES-2010")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("INSEE - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INSEE", resource = "data",
                   flowRef = "CONSO-MENAGES-2010", key = "all", key.mode = "SDMX",
                   start = 2010, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXStructureSpecificData")
  }
})

#INEGI (MEXICO)
#-------------

#-> dataflow
test_that("INEGI - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("INEGI - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "datastructure", resourceId = "SDG")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("INEGI - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "INEGI", resource = "data",
                   flowRef = "SDG", start = 2020, end = 2020)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#ISTAT (ITALY)
#-------------

#-> dataflow
test_that("ISTAT - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
#TODO investigate issue with xmlNamespaceDefinitions (XML)
test_that("ISTAT - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "datastructure", resourceId = "DCCV_CONSACQUA")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("ISTAT - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "ISTAT", resource = "data",
                   flowRef = "12_60", start = 2015, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#NOMIS (UK)
#----------

#-> dataflow
test_that("NOMIS - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NOMIS", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
#TODO check invalid XML
test_that("NOMIS - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NOMIS", resource = "datastructure", resourceId = "NM_1_1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("NOMIS - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NOMIS", resource = "data", flowRef="NM_1_1")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXCompactData")
  }
})

#UKDS (UK)
#----------

#-> datastructure
#test_that("UKDS - datastructure",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "UKDS", resource = "datastructure", resourceId = "QNA")
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXDataStructureDefinition")
#  }
#})

#-> data
#test_that("UKDS - data",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "UKDS", resource = "data", flowRef="QNA",
#                   key = "AUS+AUT.GDP+B1_GE.CUR+VOBARSA.Q", key.mode = "SDMX",
#                   start = 2000, end = 2000, dsd =TRUE)
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXMessageGroup")
#  }
#})

#LSD (LITHUANIA)
#-------------

#-> dataflow
test_that("LSD - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "LSD", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("LSD - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "LSD", resource = "datastructure", resourceId = "M8020420")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("LSD - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "LSD", resource = "data",
                   flowRef = "S3R629_M3010217", start = 2010, end = 2015)
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})

#NCSI (OMAN)
#-------------

#-> dataflow
test_that("NCSI - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NCSI", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

#-> datastructure
test_that("NCSI - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "NCSI", resource = "datastructure", resourceId = "OMFSRS2016")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
#TODO needs authorization
#test_that("NCSI - data",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "NCSI", resource = "data", flowRef = "OMFSRS2016", start = 2010, end = 2015)
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXStructureSpecificData")
#  }
#})

#STAT_E (Estonia)
#-------------

#-> datastructure
test_that("STAT_EE - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "STAT_EE", resource = "datastructure", resourceId = "KK11")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

#-> data
test_that("STAT_EE - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "STAT_EE", resource = "data",
                   flowRef = "KK11", key = "all", key.mode = "SDMX",
                   start = "2015", end = "2015")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXMessageGroup")
  }
})


#BBK (Bundesbank)
#-------------
#-> dataflow
test_that("BBK - dataflow",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BBK", resource = "dataflow")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataFlows")
  }
})

test_that("BBK - datastructure",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BBK", resource = "datastructure", resourceId = "BBK_SEDI")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXDataStructureDefinition")
  }
})

test_that("BBK - data",{
  testthat::skip_on_cran()
  sdmx <- readSDMX(providerId = "BBK", resource = "data", flowRef = "BBSIS", key = "D.I.ZST.B0.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A")
  if(!is.null(sdmx)){
    expect_is(sdmx, "SDMXGenericData")
  }
})


#other data providers

#KNOEMA
#------

#-> dataflow
#test_that("KNOEMA - dataflow",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "KNOEMA", resource = "dataflow")
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXDataFlows")
#  }
#})

#-> datastructure
#test_that("KNOEMA - datastructure",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "KNOEMA", resource = "datastructure", resourceId = "SADG2015")
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXDataStructureDefinition")
#  }
#})

#-> data
#test_that("KNOEMA - data",{
#  testthat::skip_on_cran()
#  sdmx <- readSDMX(providerId = "KNOEMA", resource = "data", flowRef = "SADG2015")
#  if(!is.null(sdmx)){
#    expect_is(sdmx, "SDMXStructureSpecificData")
#  }
#})
