# test_RequestBuilder.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Service request builder
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXRequestBuilder")

test_that("a custom SDMXRequestBuilder",{
  
  request <- SDMXRequestBuilder(
    regUrl = "http://www.myorg.org/registry",
    repoUrl = "http://www.myorg.org/repository",
    formatter = list(
      dataflow = function(obj){return(obj)},
      datastructure = function(obj){return(obj)},
      data = function(obj){return(obj)}
    ),
    handler = list(
      dataflow = function(obj){return(obj@regUrl)},
      datastructure = function(obj){return(obj@regUrl)},
      data = function(obj){
        req <- sprintf("%s/%s/data/%s/%s/%s/%s",
                       obj@repoUrl, obj@agencyId, obj@flowRef, obj@key,
                       obj@start, obj@end)
        return(req)
      }
    ),
    compliant = TRUE)
  
  expect_is(request, "SDMXRequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@formatter, "list")
  expect_is(request@handler, "list")
  expect_equal(request@compliant, TRUE)
  
  params <- SDMXRequestParams(regUrl = "http://www.myorg.org/registry",
                                repoUrl = "http://www.myorg.org/repository",
                                providerId = "MYORG", agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                                key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  webRequest <- request@handler$data(params)
  expect_equal(webRequest, "http://www.myorg.org/repository/MYORG/data/FLOW/KEY/2000/2010")
  
})

test_that("a simple SDMXREST20RequestBuilder",{
  
  request <- SDMXREST20RequestBuilder(regUrl = "http://www.myorg.org/registry",
                                    repoUrl = "http://www.myorg.org/repository",
                                    compliant = TRUE)
  
  expect_is(request, "SDMXREST20RequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@formatter, "list")
  expect_is(request@handler, "list")
  expect_equal(request@compliant, TRUE)
  
  params <- SDMXRequestParams(regUrl = "http://www.myorg.org/registry",
                              repoUrl = "http://www.myorg.org/repository",
                              providerId = "MYORG", agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                              key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  webRequest <- request@handler$data(params)
  expect_equal(webRequest, "http://www.myorg.org/repository/Data/FLOW/KEY/MYORG?startPeriod=2000&endPeriod=2010")
  
})

test_that("a simple SDMXREST21RequestBuilder",{
  
  request <- SDMXREST21RequestBuilder(regUrl = "http://www.myorg.org/registry",
                                      repoUrl = "http://www.myorg.org/repository",
                                      compliant = TRUE)
  
  expect_is(request, "SDMXREST21RequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@formatter, "list")
  expect_is(request@handler, "list")
  expect_equal(request@compliant, TRUE)
  
  params <- SDMXRequestParams(regUrl = "http://www.myorg.org/registry",
                              repoUrl = "http://www.myorg.org/repository",
                              providerId = "MYORG", agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                              key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  webRequest <- request@handler$data(params)
  expect_equal(webRequest, "http://www.myorg.org/repository/data/FLOW/KEY/all/?startPeriod=2000&endPeriod=2010")
  
})

test_that("a simple SDMXDotStatRequestBuilder",{
  
  request <- SDMXDotStatRequestBuilder(regUrl = "http://www.myorg.org/registry",
                                      repoUrl = "http://www.myorg.org/repository")
  
  expect_is(request, "SDMXDotStatRequestBuilder")
  expect_equal(request@regUrl, "http://www.myorg.org/registry")
  expect_equal(request@repoUrl, "http://www.myorg.org/repository")
  expect_is(request@formatter, "list")
  expect_is(request@handler, "list")
  expect_equal(request@compliant, FALSE)
  
  params <- SDMXRequestParams(regUrl = "http://www.myorg.org/registry",
                              repoUrl = "http://www.myorg.org/repository",
                              providerId = "MYORG", agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                              key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  webRequest <- request@handler$data(params)
  expect_equal(webRequest, "http://www.myorg.org/repository/GetData/FLOW/KEY/all?startPeriod=2000&endPeriod=2010")
  
})


test_that("a simple SDMXDotStatRequestBuilder - customized with some formatting",{
  
  request <- SDMXDotStatRequestBuilder(regUrl = "http://www.myorg.org/registry",
                                       repoUrl = "http://www.myorg.org/repository")
  
  request@formatter$data <- function(obj){
    obj@flowRef <- paste0("**_",obj@flowRef,"_**")
    return(obj)
  }
  
  params <- SDMXRequestParams(regUrl = "http://www.myorg.org/registry",
                              repoUrl = "http://www.myorg.org/repository",
                              providerId = "MYORG", agencyId = "MYORG", resource = "data", flowRef = "FLOW", resourceId = NULL,
                              key = "KEY", start = 2000, end = 2010, compliant = TRUE)
  params <- request@formatter$data(params)
  webRequest <- request@handler$data(params)
  expect_equal(webRequest, "http://www.myorg.org/repository/GetData/**_FLOW_**/KEY/all?startPeriod=2000&endPeriod=2010")
  
})

