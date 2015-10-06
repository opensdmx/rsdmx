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
    handler = function(baseUrl, agencyId, resource, flowRef, key, start, end, compliant){
      return(paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/"))
    },
    compliant = TRUE)
  
  expect_is(request, "SDMXRequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_is(request@handler, "function")
  expect_equal(request@compliant, TRUE)
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", agencyId = "MYORG", resource = "data", flowRef = "FLOW",
                                key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  expect_equal(webRequest, "http://www.myorg.org/MYORG/data/FLOW/KEY/2000/2010")
  
})


test_that("SDMXRESTRequestBuilder",{
  
  request <- SDMXRESTRequestBuilder(baseUrl = "http://www.myorg.org", compliant = TRUE)
  
  expect_is(request, "SDMXRESTRequestBuilder")
  expect_equal(request@baseUrl, "http://www.myorg.org")
  expect_is(request@handler, "function")
  expect_equal(request@compliant, TRUE)
  
  webRequest <- request@handler(baseUrl = "http://www.myorg.org", agencyId = "MYORG", resource = "data", flowRef = "FLOW",
                                key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  expect_equal(webRequest, "http://www.myorg.org/data/FLOW/KEY/?startPeriod=2000&endPeriod=2010")
  
})

