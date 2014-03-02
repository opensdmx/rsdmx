# test_Header.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for SDMX Header methods
#=======================
require(rsdmx, quietly = TRUE)
require(testthat)
context("SDMXHeader")

#read test data
file <- system.file("data", "SDMXMessageExample.xml", package = "rsdmx")
xmlObj <- xmlParse(file)

test_that("SDMXHeader",{
	obj = SDMXHeader(xmlObj)
	expect_is(obj, "SDMXHeader")
	expect_equal(obj@ID, "data.organization.org")
	expect_false(obj@Test)
	expect_false(obj@Truncated)
	expect_equal(obj@Name, "thename")
	expect_equal(obj@Prepared, as.POSIXlt(strptime("2014-03-02T16:29:26", format = "%Y-%m-%dT%H:%M:%S")))
	expect_is(obj@Sender, "list")
	expect_equal(obj@Sender$id, "ORGANIZATION")
	expect_equal(obj@Sender$name$en, "Organization")
	expect_equal(obj@Sender$name$fr, "Organisation")
	expect_equal(obj@Receiver$id, NA)
	expect_equal(obj@ReportingBegin, as.POSIXlt(strptime(ISOdate(2000,1,1), format = "%Y-%m-%d")))
	expect_equal(obj@ReportingEnd, as.POSIXlt(strptime(ISOdate(2008,12,31), format = "%Y-%m-%d")))
})

