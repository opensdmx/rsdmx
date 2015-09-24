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
    suffix = TRUE,
    handler = function(baseUrl, agencyId, suffix, operation, key, filter, start, end){
      return(paste(baseUrl, agencyId, operation, key, filter, start, end, sep="/"))
    })
  
  expect_is(request, "SDMXRequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_equal(request@suffix, TRUE)
  expect_is(request@handler, "function")
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", agencyId = "MYORG", suffix = TRUE, operation = "data", key = "KEY",
                                filter = "FILTER", start = 2000, end = 2010)
  expect_equal(webRequest, "http://www.myorg.org/MYORG/data/KEY/FILTER/2000/2010")
  
})


test_that("SDMXRESTRequestBuilder",{
  
  request <- SDMXRESTRequestBuilder(baseUrl = "http://www.myorg.org", suffix = TRUE)
  
  expect_is(request, "SDMXRESTRequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_equal(request@suffix, TRUE)
  expect_is(request@handler, "function")
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", agencyId = "MYORG", suffix = TRUE, operation = "data", key = "KEY",
                                filter = "FILTER", start = 2000, end = 2010)
  expect_equal(webRequest, "http://www.myorg.org/data/KEY/FILTER/MYORG?startPeriod=2000&endPeriod=2010")
  
})

