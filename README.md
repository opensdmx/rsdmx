**rsdmx**
=======
[![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)](https://travis-ci.org/opensdmx/rsdmx)
[![codecov.io](http://codecov.io/github/opensdmx/rsdmx/coverage.svg?branch=master)](http://codecov.io/github/opensdmx/rsdmx?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rsdmx)](http://cran.r-project.org/package=rsdmx)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.5--0-blue.svg)](https://github.com/opensdmx/rsdmx)

``rsdmx``: Tools  for reading SDMX data and metadata documents in R

## Overview

``rsdmx`` is a package to parse/read SDMX data and metadata in R. It provides a set of classes and methods to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML). [Learn more](https://github.com/opensdmx/rsdmx/wiki#package_overview).

**SDMX standards compliance**

[![SDMX_Compliance_Badge_1.0](https://img.shields.io/badge/SDMX--ML-1.0-blue.svg)](https://github.com/opensdmx/rsdmx)
[![SDMX_Compliance_Badge_2.0](https://img.shields.io/badge/SDMX--ML-2.0-blue.svg)](https://github.com/opensdmx/rsdmx)
[![SDMX_Compliance_Badge_2.1](https://img.shields.io/badge/SDMX--ML-2.1-blue.svg)](https://github.com/opensdmx/rsdmx)

**Status**
At now, the package allows to read:
* Datasets (``GenericData``, ``CompactData``, ``StructureSpecificData``, ``UtilityData`` and ``MessageGroup`` SDMX-ML types)
* Concepts (``Concept``, ``ConceptScheme`` and ``Concepts`` SDMX-ML types)
* Codelists (``Code``, ``Codelist`` and ``Codelists`` SDMX-ML types)
* DataStructures / KeyFamilies - with all subtypes
* Data Structure Definitions (DSDs) - with all subtypes


**Fundings**
 ``rsdmx`` is looking for **[sponsors](https://github.com/opensdmx/rsdmx/wiki#package_development_funding) **. You have been using ``rsdmx`` and you wish to support its development? Please help us to make the package growing!


**Citation**:
We thank in advance people that use ``rsdmx`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.11551.png)](http://dx.doi.org/10.5281/zenodo.11551)


**R CRAN rsdmx check results:**

[http://cran.r-project.org/web/checks/check_results_rsdmx.html](http://cran.r-project.org/web/checks/check_results_rsdmx.html)

Please note that following a new submission to CRAN, or eventually a modification of CRAN policies, the package might be temporarily archived, and removed from CRAN. In case you notice that the package is not back in few time, please contact me.


**Mailing list:<br/>**
[https://groups.google.com/forum/#!forum/rsdmx](https://groups.google.com/forum/#!forum/rsdmx)<br/>
You can subscribe directly in the google group, or by email: [rsdmx+subscribe@googlegroups.com](rsdmx+subscribe@googlegroups.com)
To send a post, use: [rsdmx@googlegroups.com](rsdmx@googlegroups.com)
To unsubscribe, send an email to: [rsdmx+unsubscribe@googlegroups.com](rsdmx+unsubscribe@googlegroups.com)

## Quickstart

[rsdmx](http://cran.r-project.org/package=rsdmx) offers a low-level set of tools to read **data** and **metadata** in SDMX format. Its strategy is to make it very easy for the user. For this, a unique function named ``readSDMX`` has to be used, whatever it is a ``data`` or ``metadata`` document, or if it is ``local`` or ``remote`` datasource.

It is important to highlight that one of the major benefits of ``rsdmx`` is to focus first on the SDMX **format** specifications (acting as format abstraction library). This allows ``rsdmx`` reading SDMX data from _remote_ datasources, or from _local_ SDMX files. For accessing _remote_ datasources, it also means that ``rsdmx`` does not bound to SDMX **service** specifications, and can read a wider ranger of datasources.


### Install rsdmx

``rsdmx`` can be installed from CRAN
```{r, echo = FALSE}
install.packages("rsdmx")
```

or from its development repository hosted in Github (using the ``devtools`` package):

```{r, echo = FALSE}
devtools::install_github("opensdmx/rsdmx")
```

### Load rsdmx

To load rsdmx in R, do the following:

```{r, echo = FALSE}
library(rsdmx)
```

### readSDMX & helper functions


#### readSDMX as low-level function

The ``readSDMX`` function is then first designed at low-level so it can take as parameters a _url_ (``isURL=TRUE`` by default) or a _file_. So wherever is located the SDMX document, ``readSDMX`` will allow you to read it, as follows:

```{r, echo = FALSE}

  #read a remote file
  sdmx <- readSDMX(file = "someUrl")
  
  #read a local file
  sdmx <- readSDMX(file = "somelocalfile", isURL = FALSE)

```

In addition, in order to facilitate querying datasources, ``readSDMX`` also providers helpers to query well-known remote datasources. This allows not to specify the entire URL, but rather specify a simple provider ID, and the different parameters to build a SDMX query (e.g. for a dataset query: operation, key, filter, startPeriod and endPeriod). 

This is made possible as a list of SDMX service providers is embedded within ``rsdmx``, and such list provides all the information required for ``readSDMX`` to build the SDMX request (url) before accessing the datasource.


#### get list of SDMX service providers

The list of known SDMX service providers can be queried as follows:

```{r, echo = FALSE}

providers <- getSDMXServiceProviders()

#list all provider ids
sapply(providers, function(x) slot(x, "id"))

```

#### create/add a SDMX service provider

It also also possible to create and add a new SDMX service providers in this list (so ``readSDMX`` can be aware of it). A provider can be created with the ``SDMXServiceProvider``, and is made of three parameters: an ``id``, its ``name``, and a request ``builder``.

The request builder can be created with ``SDMXRequestBuilder`` which takes 3 arguments: the ``baseUrl`` of the service endpoint, a service url ``suffix``, and a ``handler`` function which will allow to build the web request.

``rsdmx`` intends to provider specific request builder that embedds yet an handler function (not need to implement it), and is now attempting to provide a ``SDMX21RequestBuilder`` to build SDMX 2.1 REST web-requests. All this is still under experiments.

Let's see it with an example:

First create a request builder for our provider:

```{r, echo = FALSE}

myBuilder <- SDMXRequestBuilder(
  baseUrl = "http://www.myorg.org/sdmx",
  suffix = "service",
  handler = function(baseUrl, operation, key, filter, suffix, start, end){
    paste(baseUrl, operation, key, filter, paste0(suffix, "?startPeriod=", start, "&endPeriod=", end), sep="/")
  }
)
```

As you can see, we built a handler that will be in charge of creating a web-request such as [http://www.myorg.org/sdmx/operation/key/filter/suffix?startPeriod=start&endPeriod=end](http://www.myorg.org/sdmx/operation/key/filter/suffix?startPeriod=start&endPeriod=end)

We can create a provider with the above request builder, and add it to the list of known SDMX service providers:

```{r, echo = FALSE}

#create the provider
provider <- SDMXServiceProvider(
id = "MYORG",
name = "My Organization",
builder = myBuilder
)

#add it to the list
addSDMXServiceProvider(provider)

#check provider has been added
sapply(getSDMXServiceProviders(), function(x){slot(x, "id")})


```

#### find a SDMX service provider

A another helper allows you to interrogate ``rsdmx`` if a specific provider is known, given an id:

```{r, echo = FALSE}
oecd <- findSDMXServiceProvider("OECD")
```

#### readSDMX as helper function

Now you know how to add a SDMX provider, you can consider using ``readSDMX`` without having to specifying a entire URL, but just by specifying the ``id`` of the provider, and the different query parameters to reach your SDMX document:

```{r, echo = FALSE}
sdmx <- readSDMX(id = "MYORG", operation = "data", key="MYSERIE", filter="ALL", start = 2000, end = 2015)
```

The following sections will show you how to query SDMX documents, by using ``readSDMX`` in different ways: either for _local_ or _remote_ files, using ``readSDMX`` as low-level or with the helpers.

### Read dataset documents

This section will introduce you on how to read SDMX *dataset* documents.

#### Read _remote_ datasets


The following code snipet shows you how to read a dataset from a remote data source, taking as example the [FAO data portal](http://data.fao.org/sdmx/index.html): [http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008](http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008)

```{r, echo = FALSE}
myUrl <- "http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008"
dataset <- readSDMX(myUrl)
stats <- as.data.frame(dataset) 
```

You can try it out with other datasources, such as:
* [**OECD StatExtracts portal**](http://stats.oecd.org): [http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MIG/TOT../OECD?startTime=2000&endTime=2011](http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MIG/TOT../OECD?startTime=2000&endTime=2011)
* [**EUROSTAT portal**](http://epp.eurostat.ec.europa.eu/portal/page/portal/sdmx_web_services/getting_started/rest_sdmx_2.1): [http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011](http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011)
* [**European Central Bank (ECB)**](https://sdw-wsrest.ecb.europa.eu): [https://sdw-wsrest.ecb.europa.eu/service/data/DD/M.SE.BSI_STF.RO.4F_N](https://sdw-wsrest.ecb.europa.eu/service/data/DD/M.SE.BSI_STF.RO.4F_N)
* [**UN International Labour Organization (ILO)**](http://www.ilo.org/ilostat/faces/home/statisticaldata/technical_page?_adf.ctrl-state=25zdozvi8_9&_afrLoop=1131342564621899): [http://www.ilo.org/ilostat/sdmx/ws/rest/data/ILO,DF_CPI_FRA_CPI_TCPI_COI_RT/ALL?startPeriod=2000-01-01&endPeriod=2014-12-31](http://www.ilo.org/ilostat/sdmx/ws/rest/data/ILO,DF_CPI_FRA_CPI_TCPI_COI_RT/ALL?startPeriod=2000-01-01&endPeriod=2014-12-31)

The online rsdmx documentation also provides a list of data providers, either from international or national institutions.

Now, the service providers above mentioned are known by ``rsdmx`` which let users using ``readSDMX`` with the helper parameters. Let's see how it would look like for querying an OECD datasource:

```{r, echo = FALSE}
sdmx <- readSDMX(id = "OECD", operation = "GetData", key = "MIG",
                 filter = list("TOT", NULL, NULL), start = 2011, end = 2011)
df <- as.data.frame(sdmx)
head(df)
```


#### Read _local_ datasets

This example shows you how to use ``rsdmx`` with _local_ SDMX files, previously downloaded from [EUROSTAT](http://ec.europa.eu/eurostat).

```{r, echo = FALSE}
#bulk download from Eurostat
tf <- tempfile(tmpdir = tdir <- tempdir()) #temp file and folder
download.file("http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Frd_e_gerdsc.sdmx.zip", tf)
sdmx_files <- unzip(tf, exdir = tdir)

sdmx <- readSDMX(sdmx_files[2], isURL = FALSE)
stats <- as.data.frame(sdmx)
head(stats)

```

By default, ``readSDMX`` considers the data source is remote. To read a local file, add ``isURL = FALSE``.

### Read metadata documents

This section will introduce you on how to read SDMX **metadata** documents, including ``concepts``, ``codelists`` and complete ``data structure definitions`` (DSD)

#### Concepts

Read concept schemes from [FAO data portal](http://data.fao.org/sdmx/index.html)

```{r, echo = FALSE}
csUrl <- "http://data.fao.org/sdmx/registry/conceptscheme/FAO/ALL/LATEST/?detail=full&references=none&version=2.1"
csobj <- readSDMX(csUrl)
csdf <- as.data.frame(csobj)
head(csdf)
```

#### Codelists

Read codelists from [FAO data portal](http://data.fao.org/sdmx/index.html)
```{r, echo = FALSE}
clUrl <- "http://data.fao.org/sdmx/registry/codelist/FAO/CL_FAO_MAJOR_AREA/0.1"
clobj <- readSDMX(clUrl)
cldf <- as.data.frame(clobj)
head(cldf)
```

#### Data Structures (Key Families)

This example illustrates how to read the complete list of data structures (or key families) from the [OECD StatExtracts portal](http://stats.oecd.org)

```{r, echo = FALSE}
dsUrl <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/ALL"
ds <- readSDMX(dsUrl)
dsdf <- as.data.frame(ds)
head(dsdf)
```

#### Data Structure Definition (DSD)

This example illustrates how to read a complete DSD using a [OECD StatExtracts portal](http://stats.oecd.org) data source.

```{r, echo = FALSE}
dsdUrl <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/TABLE1"
dsd <- readSDMX(dsdUrl)
```

``rsdmx`` is implemented in object-oriented way with ``S4`` classes and methods. The properties of ``S4`` objects are named ``slots`` and can be accessed with the ``slot`` method. The following code snippet allows to extract the list of ``codelists`` contained in the DSD document, and read one codelist as ``data.frame``.

```{r, echo = FALSE}
#get codelists from DSD
cls <- slot(dsd, "codelists")
codelists <- sapply(slot(cls, "codelists"), function(x) slot(x, "id")) #get list of codelists
codelist <- as.data.frame(slot(dsd, "codelists"), codelistId = "CL_TABLE1_FLOWS") #get a codelist
```

In a similar way, the ``concepts`` of the dataset can be extracted from the DSD and read as ``data.frame``.

```{r, echo = FALSE}
#get concepts from DSD
concepts <- as.data.frame(slot(dsd, "concepts"))
```
