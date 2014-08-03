# test_MessageGroup.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX MessageGroup methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXMessageGroup")

test_that("MessageGroup - GenericData 2.0",{
  file <- system.file("data", "SDMXMessageGroupExample_GenericData_2.0.xml",
                      package = "rsdmx")
  xmlObj <- xmlParse(file)

	ds <- SDMXMessageGroup(xmlObj)
	expect_is(ds, "SDMXMessageGroup")
	
	df <- as.data.frame(ds)
	expect_is(df, "data.frame")
})
