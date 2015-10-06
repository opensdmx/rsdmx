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
    regUrl = "http://www.myorg.org/registry",
    repoUrl = "http://www.myorg.org/repository",
    handler = function(regUrl, repoUrl, agencyId, resource, resourceId, version,
                       flowRef, key, start, end, compliant){
      return(paste(repoUrl, agencyId, resource, flowRef, key, start, end, sep="/"))
    },
    compliant = TRUE)
  
  expect_is(request, "SDMXRequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@handler, "function")
  expect_equal(request@compliant, TRUE)
  
  webRequest <- request@handler(regUrl = "http://www.myorg.org/registry", repoUrl = "http://www.myorg.org/repository",
                                agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                                key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  expect_equal(webRequest, "http://www.myorg.org/repository/MYORG/data/FLOW/KEY/2000/2010")
  
})


test_that("SDMXRESTRequestBuilder",{
  
  request <- SDMXRESTRequestBuilder(regUrl = "http://www.myorg.org/registry",
                                    repoUrl = "http://www.myorg.org/repository",
                                    compliant = TRUE)
  
  expect_is(request, "SDMXRESTRequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@handler, "function")
  expect_equal(request@compliant, TRUE)
  
  webRequest <- request@handler(regUrl = "http://www.myorg.org/registry", repoUrl = "http://www.myorg.org/repository",
                                agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                                key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  expect_equal(webRequest, "http://www.myorg.org/repository/data/FLOW/KEY/?startPeriod=2000&endPeriod=2010")
  
})

