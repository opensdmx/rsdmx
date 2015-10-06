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
    regUrl = "http://www.myorg.org/registry",
    repoUrl = "http://www.myorg.org/repository",
    handler = function(baseUrl, agencyId, resource, resourceId, version,
                       flowRef, key, start, end, compliant){
      return(paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/"))
    },
    compliant = TRUE)
  
  
  provider <- SDMXServiceProvider(
    agencyId = "MYORG", name = "My Organization",
    builder = requestBuilder
  )
  
  expect_is(provider, "SDMXServiceProvider")
  expect_equal(provider@agencyId, "MYORG")
  expect_equal(provider@name, "My Organization")
  expect_equal(provider@scale, "international")
  expect_true(is.na(provider@country))
  expect_is(provider@builder, "SDMXRequestBuilder")
  
})


test_that("SDMXServiceProvider - methods",{
    
  providers <- getSDMXServiceProviders()
  expect_is(providers, "SDMXServiceProviders")
  expect_equal(length(providers@providers), 7L)
  expect_equal(sapply(providers@providers, function(x){slot(x,"agencyId")}),
               c("ECB", "ESTAT", "OECD", "FAO", "ILO", "UIS", "NBB"))
  expect_is(as.data.frame(providers), "data.frame")
  
  #add a provider
  requestBuilder <- SDMXRequestBuilder(
    regUrl = "http://www.myorg.org/registry",
    repoUrl = "http://www.myorg.org/repository",
    handler = function(baseUrl, agencyId, resource, resourceId, version, 
                       flowRef, key, start, end, compliant){
      return(paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/"))
    },
    compliant = TRUE)
  
  provider <- SDMXServiceProvider(
    agencyId = "MYORG", name = "My Organization",
    builder = requestBuilder
  )
  
  addSDMXServiceProvider(provider)
  providers <- getSDMXServiceProviders()
  expect_equal(length(providers@providers), 8L)
  expect_equal(sapply(providers@providers, function(x){slot(x,"agencyId")}),
               c("ECB", "ESTAT", "OECD", "FAO", "ILO", "UIS", "NBB", "MYORG"))
  
  #find a provider
  oecd <- findSDMXServiceProvider("OECD")
  expect_is(oecd, "SDMXServiceProvider")
  expect_equal(oecd@agencyId, "OECD")
  
})

