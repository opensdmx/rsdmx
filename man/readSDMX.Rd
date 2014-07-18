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
\item{hhead}{optional list of httpheader information passed to getURL }
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
#using SDMX 2.0
tmp <- system.file("data","Example_Eurostat_2.0.xml", package="rsdmx")
sdmx3 <- readSDMX(tmp, isURL = FALSE)
stats3 <- as.data.frame(sdmx3)
head(stats3)

#using SDMX 2.1
tmpnew <- system.file("data","Example_Eurostat_2.1.xml", package="rsdmx")
sdmx4 <- readSDMX(tmpnew, isURL = FALSE)
stats4 <- as.data.frame(sdmx4)
head(stats4)

# Eurostat data via web-service (REST)
url <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/bop_euins_q/Q.EUR.100.NET.EUR.COMM/?startperiod=2013-Q1"
sdmx <- readSDMX(url, hhead=list('User-Agent'='R'))
stats <- as.data.frame(sdmx)
head(stats)
}
