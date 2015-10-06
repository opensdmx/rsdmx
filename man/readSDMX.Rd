\name{readSDMX}
\Rdversion{1.1}
\alias{readSDMX}

\title{readSDMX}

\description{\code{readSDMX} is the main function to use to read SDMX data}

\usage{
readSDMX(file, isURL,
         provider, agencyId, resource, resourceId, version,
         flowRef, key, key.mode, start, end)
}

\arguments{
\item{file}{path to SDMX-ML document that needs to be parsed}
\item{isURL}{a value of class "logical" either the path is an url, and data has to be downloaded from a SDMXweb-repository. Default value is TRUE. Ignored in case \code{readSDMX} is used with helpers (based on the embedded list of \code{SDMXServiceProvider} or a
specific provider given as argument)}
\item{provider}{an object of class "SDMXServiceProvider". If specified, \code{file} and \code{isURL} arguments will be ignored.}
\item{agencyId}{an object of class "character" representing a provider id. It has to be match a default provider as listed in \code{getSDMXServiceProviders()}}
\item{resource}{An object of class "character" giving the SDMX service request resource to query e.g. "data". Recognized if a valid provider or provide id has been specified as argument.}
\item{resourceId}{An object of class "character" giving a SDMX service resource Id, e.g. the id of a data structure}
\item{version}{An object of class "character" giving a SDMX resource version, e.g. the version of a dataflow}
\item{flowRef}{An object of class "character" giving the SDMX flow ref (data structure) id. Recognized if valid provider or provide id has been specified as argument.}
\item{key}{An object of class "character" or "list" giving the SDMX data key/filter to apply. Recognized if a valid provider or provide id has been specified as argument. If \code{key.mode} is equal to \code{"R"} (default value), filter has to be an object of class "list" representing the filters to apply to the dataset, otherwise the filter will be a string.}
\item{key.mode}{An object of class "character" indicating if the \code{key} has to be provided as an R object, ie a object of class "list" representing the filter(s) to apply. Default value is \code{"R"}. Alternative value is \code{"SDMX"}}
\item{start}{An object of class "integer" or "character" giving the SDMX start time to apply. Recognized if a valid provider or provide id has been specified as argument.}
\item{end}{An object of class "integer" or "character" giving the SDMX end time to apply. Recognized if a valid provider or provide id has been specified as argument.}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

# SDMX datasets
#--------------
\dontrun{
# Not run
# (local dataset examples)
#with SDMX 2.0
tmp <- system.file("extdata","Example_Eurostat_2.0.xml", package="rsdmx")
sdmx4 <- readSDMX(tmp, isURL = FALSE)
stats4 <- as.data.frame(sdmx4)
head(stats4)

#with SDMX 2.1
tmpnew <- system.file("extdata","Example_Eurostat_2.1.xml", package="rsdmx")
sdmx5 <- readSDMX(tmpnew, isURL = FALSE)
stats5 <- as.data.frame(sdmx5)
head(stats5)
## End(**Not run**)
}

\donttest{
# Not run by 'R CMD check'
# (reliable remote datasource but with possible occasional unavailability)

#examples using 'file' argument
#example 1: FAO data
url1 <- paste("http://data.fao.org/sdmx/repository/data/",
              "CROP_PRODUCTION/.156.5312.515./FAO?startPeriod=2008&endPeriod=2008",
              sep = "")
sdmx1 <- readSDMX(url1)
stats1 <- as.data.frame(sdmx1)
head(stats1)

#example 2: OECD data
url2 <- paste("http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/",
              "MIG/TOT.B11.TOT.FRA/OECD?startTime=2011&endTime=2011",
              sep = "")
sdmx2 <- readSDMX(url2)
stats2 <- as.data.frame(sdmx2)
head(stats2)

#example 3: Eurostat data 
#using url (Eurostat REST SDMX 2.1)
url3 <- paste("http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/",
              "cdh_e_fos/..PC.FOS1.BE/?startperiod=2011&endPeriod=2011",
              sep = "")
sdmx3 <- readSDMX(url3)
stats3 <- as.data.frame(sdmx3)
head(stats3)

#examples using helpers!
sdmx4 <- readSDMX(agencyId = "OECD", resource = "data", flowRef = "MIG",
                  key = list("TOT", NULL, NULL), start = 2011, end = 2011)
stats4 <- as.data.frame(sdmx4)
head(stats4)

## End(**Not run**)
}

# SDMX Concepts / ConceptSchemes
#-------------------------------
\donttest{
# Not run by 'R CMD check'
# (reliable remote datasource but with possible occasional unavailability)
csUrl <- paste("http://data.fao.org/sdmx/registry/conceptscheme",
               "/FAO/ALL/LATEST/?detail=full&references=none&version=2.1",
               sep = "")
csobj <- readSDMX(csUrl)
csdf <- as.data.frame(csobj)
head(csdf)
## End(**Not run**)
}

# SDMX Codelists
#---------------
\donttest{
# Not run by 'R CMD check'
# (reliable remote datasource but with possible occasional unavailability)
clUrl <- "http://data.fao.org/sdmx/registry/codelist/FAO/CL_FAO_MAJOR_AREA/0.1"
clobj <- readSDMX(clUrl)
cldf <- as.data.frame(clobj)
head(cldf)
## End(**Not run**)
}

# SDMX DataStructureDefinition (DSD)
#-----------------------------------
\donttest{
# Not run by 'R CMD check'
# (reliable remote datasource but with possible occasional unavailability)
dsdUrl <- paste("http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/",
                "WATER_ABSTRACT",
                sep = "")
dsd <- readSDMX(dsdUrl)

#get codelists from DSD
cls <- dsd@codelists
codelists <- sapply(cls@codelists, function(x) x@id) #get list of codelists

#get a codelist
codelist <- as.data.frame(dsd@codelists,
                          codelistId = "CL_WATER_ABSTRACT_SOURCE")

#get concepts from DSD
concepts <- as.data.frame(dsd@concepts)

## End(**Not run**)
}
}
