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
    suffix = "service",
    handler = function(baseUrl, operation, key, filter, suffix, start, end){
      return(paste(baseUrl, operation, key, filter, suffix, start, end, sep="/"))
    })
  
  
  provider <- SDMXServiceProvider(
    id = "MYORG", name = "My Organization",
    requestBuilder
  )
  
  expect_is(provider, "SDMXServiceProvider")
  expect_equal(provider@id, "MYORG")
  expect_equal(provider@name, "My Organization")
  expect_is(provider@builder, "SDMXRequestBuilder")
  
})


test_that("SDMXService - methods",{
    
  providers <- getSDMXServiceProviders()
  expect_is(providers, "list")
  expect_equal(length(providers), 5L)
  expect_equal(sapply(providers, function(x){slot(x,"id")}),
               c("ECB", "EUROSTAT", "OECD", "UN-FAO", "UN-ILO"))
  
  #add a provider
  requestBuilder <- SDMXRequestBuilder(
    baseUrl = "http://www.myorg.org",
    suffix = "service",
    handler = function(baseUrl, operation, key, filter, suffix, start, end){
      return(paste(baseUrl, operation, key, filter, suffix, start, end, sep="/"))
    })
  
  provider <- SDMXServiceProvider(
    id = "MYORG", name = "My Organization",
    requestBuilder
  )
  
  addSDMXServiceProvider(provider)
  providers <- getSDMXServiceProviders()
  expect_equal(length(providers), 6L)
  expect_equal(sapply(providers, function(x){slot(x,"id")}),
               c("ECB", "EUROSTAT", "OECD", "UN-FAO", "UN-ILO", "MYORG"))
  
  #find a provider
  oecd <- findSDMXServiceProvider("OECD")
  expect_is(oecd, "SDMXServiceProvider")
  expect_equal(oecd@id, "OECD")
  
})

