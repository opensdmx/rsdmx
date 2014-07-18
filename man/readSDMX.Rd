\name{readSDMX}
\Rdversion{1.1}
\alias{readSDMX}

\title{readSDMX}

\description{\code{readSDMX} is the main function to use to read SDMX data}

\usage{
readSDMX(file, isURL)
}

\arguments{
\item{file}{path to SDMX-ML document that needs to be parsed}
\item{isURL}{a value of class "logical" either the path is an url, and data has to be downloaded from a SDMX 
web-repository. Default value is TRUE.}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{
#example 1: FAO data
url1 <- "http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008"
sdmx1 <- readSDMX(url1)
stats1 <- as.data.frame(sdmx1)
head(stats1)

#example 2: OECD data
#url2 <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MIG/TOT../OECD?startTime=2000&endTime=2011"
#sdmx2 <- readSDMX(url2)
#stats2 <- as.data.frame(sdmx2)
#head(stats2)

#example 3: Eurostat data (local file)
tmp <- system.file("data","SDMXGenericDataExample_Eurostat.xml", package="rsdmx")
sdmx3 <- readSDMX(tmp, isURL = FALSE)
stats3 <- as.data.frame(sdmx3)
head(stats3)
}
