# test_OrganisationSchemes.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX DataStructures methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXOrganisationSchemes")

test_that("OrganisationSchemes - 2.1",{
  file <- system.file("extdata", "SDMXOrganisationSchemes_Example_2.1.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)
  ns <- namespaces.SDMX(xmlObj)
  os <- SDMXOrganisationSchemes(xmlObj, ns)
  expect_is(os, "SDMXOrganisationSchemes")
  expect_equal(length(os@organisationSchemes), 1L)
  
  os.df <- as.data.frame(os)
  expect_is(os.df, "data.frame")
  expect_equal(nrow(os.df), 1L)
  expect_equal(colnames(os.df), c("id","agencyID", "version",
                                  "uri", "urn", "isExternalReference", "isFinal",
                                  "validFrom", "validTo"))
  expect_equal(os.df[1,"id"], "AGENCIES")
  expect_equal(os.df[1, "agencyID"], "SDMX")
  expect_equal(os.df[1, "version"], "1.0")
  expect_equal(os.df[1, "urn"], "urn:sdmx:org.sdmx.infomodel.base.AgencyScheme=SDMX:AGENCIES(1.0)")
  
})
