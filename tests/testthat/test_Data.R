# test_Data.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Data methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXData")

test_that("DSD is properly associated to an SDMXData object",{
  data <- readSDMX(providerId = "UIS", resource = "data",
                        flowRef = "EDULIT_DS", key = list("OFST_1_CP", NULL),
                        start = "2000", end = "2015")
  dsd <- readSDMX(providerId = "UIS", resource = "datastructure",
                       resourceId = "EDULIT_DS")
  
  expect_equal(slot(data,"dsdRef"), "EDULIT_DS")
  expect_true(is.null(slot(data,"dsd")))
  
  data <- setDSD(data, dsd)
  expect_false(is.null(slot(data,"dsd")))
  expect_is(slot(data,"dsd"), "SDMXDataStructureDefinition")
  
})

test_that("DSD is properly fetched by readSDMX and associated to the dataset",{
  data <- readSDMX(providerId = "UIS", resource = "data",
                        flowRef = "EDULIT_DS", key = list("OFST_1_CP", NULL),
                        start = "2000", end = "2015",
                        dsd = TRUE)
  expect_false(is.null(slot(data,"dsd")))
  expect_is(slot(data,"dsd"), "SDMXDataStructureDefinition")
})

test_that("DSD is properly fetched by readSDMX when there is no dsdRef (using flowRef)",{
  data <- readSDMX(providerId = "KNOEMA", resource = "data",
                   flowRef = "SADG2015", dsd = TRUE)
  expect_false(is.null(slot(data,"dsd")))
  expect_is(slot(data,"dsd"), "SDMXDataStructureDefinition")
})

test_that("Dataset is correctly enriched with labels using the DSD",{
  sdmx.data <- readSDMX(providerId = "UIS", resource = "data",
                        flowRef = "CAI_DS", dsd = TRUE)
  data <- as.data.frame(sdmx.data)
  data.enriched <- as.data.frame(sdmx.data, labels = TRUE)
  expect_true(ncol(data.enriched) > ncol(data))
  expect_true(all(data["CAI_IND"] == data.enriched["CAI_IND"]))
  expect_true(all(data["LOCATION"] == data.enriched["LOCATION"]))
  expect_true(all(data["TIME_FORMAT"] == data.enriched["TIME_FORMAT"]))
  expect_true(all(data["obsTime"] == data.enriched["obsTime"]))
  expect_true(all(data["obsValue"] == data.enriched["obsValue"]))

})
