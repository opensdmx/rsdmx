# test_RequestBuilder.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Service request builder
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXRequestBuilder")

test_that("SDMXRequestBuilder",{
  
  request <- SDMXRequestBuilder(
    baseUrl = "http://www.myorg.org",
    suffix = "service",
    handler = function(baseUrl, operation, key, filter, suffix, start, end){
      return(paste(baseUrl, operation, key, filter, suffix, start, end, sep="/"))
    })
  
  expect_is(request, "SDMXRequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_equal(request@suffix, "service")
  expect_is(request@handler, "function")
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", operation = "data", key = "KEY",
                                filter = "FILTER", suffix = "service", start = 2000, end = 2010)
  expect_equal(webRequest, "http://www.myorg.org/data/KEY/FILTER/service/2000/2010")
  
})


test_that("SDMX21RequestBuilder",{
  
  request <- SDMX21RequestBuilder(
    baseUrl = "http://www.myorg.org",
    suffix = "service"
  )
  
  expect_is(request, "SDMX21RequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_equal(request@suffix, "service")
  expect_is(request@handler, "function")
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", operation = "data", key = "KEY",
                                filter = "FILTER", suffix = "service", start = 2000, end = 2010)
  expect_equal(webRequest, "http://www.myorg.org/data/KEY/FILTER/service?startPeriod=2000&endPeriod=2010")
  
})

