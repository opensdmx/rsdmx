# test_ServiceProvider.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Service Provider
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXServiceProvider")

test_that("SDMXServiceProvider - constructor",{
  
  requestBuilder <- SDMXRequestBuilder(
    baseUrl = "http://www.myorg.org",
    suffix = TRUE,
    handler = function(baseUrl, agencyId, resource, flowRef, key, start, end, compliant){
      return(paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/"))
    })
  
  
  provider <- SDMXServiceProvider(
    agencyId = "MYORG", name = "My Organization",
    builder = requestBuilder
  )
  
  expect_is(provider, "SDMXServiceProvider")
  expect_equal(provider@agencyId, "MYORG")
  expect_equal(provider@name, "My Organization")
  expect_is(provider@builder, "SDMXRequestBuilder")
  
})


test_that("SDMXServiceProvider - methods",{
    
  providers <- getSDMXServiceProviders()
  expect_is(providers, "list")
  expect_equal(length(providers), 6L)
  expect_equal(sapply(providers, function(x){slot(x,"agencyId")}),
               c("ECB", "ESTAT", "OECD", "FAO", "ILO", "UIS"))
  
  #add a provider
  requestBuilder <- SDMXRequestBuilder(
    baseUrl = "http://www.myorg.org",
    suffix = TRUE,
    handler = function(baseUrl, agencyId, suffix, operation, key, filter, start, end){
      return(paste(baseUrl, agencyId, operation, key, filter, start, end, sep="/"))
    })
  
  provider <- SDMXServiceProvider(
    agencyId = "MYORG", name = "My Organization",
    builder = requestBuilder
  )
  
  addSDMXServiceProvider(provider)
  providers <- getSDMXServiceProviders()
  expect_equal(length(providers), 7L)
  expect_equal(sapply(providers, function(x){slot(x,"agencyId")}),
               c("ECB", "ESTAT", "OECD", "FAO", "ILO", "UIS", "MYORG"))
  
  #find a provider
  oecd <- findSDMXServiceProvider("OECD")
  expect_is(oecd, "SDMXServiceProvider")
  expect_equal(oecd@agencyId, "OECD")
  
})

