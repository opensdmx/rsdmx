# rsdmx <a href="https://github.com/eblondel/rsdmx"><img src='https://github.com/eblondel/rsdmx/blob/master/doc/rsdmx.png?raw=true' align="right" height="139" /></a>

[![Build Status](https://github.com/eblondel/rsdmx/actions/workflows/r-cmd-check.yml/badge.svg?branch=master)](https://github.com/eblondel/rsdmx/actions/workflows/r-cmd-check.yml)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rsdmx)](https://cran.r-project.org/package=rsdmx)
[![cran checks](https://badges.cranchecks.info/worst/rsdmx.svg)](https://cran.r-project.org/web/checks/check_results_rsdmx.html)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.6--5-blue.svg)](https://github.com/eblondel/rsdmx)
[![R-Universe](https://eblondel.r-universe.dev/badges/rsdmx)](http://eblondel.r-universe.dev/#package:rsdmx)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.592404.svg)](https://doi.org/10.5281/zenodo.592404)

** Tools for reading SDMX data and metadata documents in R ** 

## Overview

``rsdmx`` is a package to parse/read SDMX data and metadata in R. It provides:
* a set of classes and methods to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML).
* an interface to SDMX web-services for a list of well-known data providers, such as EUROSTAT, OECD, and others 
[Learn more](https://github.com/eblondel/rsdmx/wiki#package_overview).

### Citation

We thank in advance people that use ``rsdmx`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/5183/eblondel/rsdmx.svg)](https://doi.org/10.5281/zenodo.592404)

### Collating scattered SDMX data sources

In spite they are some R package initiatives relying on ``rsdmx`` that aim to provide a wrapper for a _single data source_ (e.g. OECD, EUROSTAT), it is strongly recommended to rely directly on ``rsdmx``. Indeed, one main objective of ``rsdmx`` is to **promote and facilitate collating scattered data** from a growing number of SDMX data providers, whatever the organization.

It is already possible to query well-known datasources, using the embedded [helpers](https://github.com/eblondel/rsdmx/blob/master/vignettes/quickstart.Rmd#using-the-helper-approach). Pull requests are welcome to support additional data providers by default in ``rsdmx``.

### SDMX standards compliance

[![SDMX_Compliance_Badge_1.0](https://img.shields.io/badge/SDMX--ML-1.0-blue.svg)](https://github.com/eblondel/rsdmx)
[![SDMX_Compliance_Badge_2.0](https://img.shields.io/badge/SDMX--ML-2.0-blue.svg)](https://github.com/eblondel/rsdmx)
[![SDMX_Compliance_Badge_2.1](https://img.shields.io/badge/SDMX--ML-2.1-blue.svg)](https://github.com/eblondel/rsdmx)

### Status
At now, the package allows to read:
* Datasets (``GenericData``, ``CompactData``, ``StructureSpecificData``, ``StructureSpecificTimeSeriesData``, ``CrossSectionalData``, ``UtilityData`` and ``MessageGroup`` SDMX-ML types)
* Concepts (``Concept``, ``ConceptScheme`` and ``Concepts`` SDMX-ML types)
* Codelists (``Code``, ``Codelist`` and ``Codelists`` SDMX-ML types)
* DataStructures / KeyFamilies - with all subtypes
* Data Structure Definitions (DSDs) - with all subtypes

### Fundings

``rsdmx`` is looking for **[sponsors](https://github.com/eblondel/rsdmx/wiki#package_development_funding)**. You have been using ``rsdmx`` and you wish to support its development? Please help us to make the package growing!

### Author

Copyright (C) 2014  Emmanuel Blondel

### Contributors

* Matthieu Stigler
* Eric Persson

### Distribution

#### on CRAN
``rsdmx`` is available on the Comprehensive R Archive Network (CRAN). See the R CRAN check results at: [https://cran.r-project.org/web/checks/check_results_rsdmx.html](https://cran.r-project.org/web/checks/check_results_rsdmx.html)

Please note that following a new submission to CRAN, or eventually a modification of CRAN policies, the package might be temporarily archived, and removed from CRAN. In case you notice that the package is not back in few time, please contact me.

#### on R-Universe
``rsdmx`` is available on the R-Universe public cloud server. The package version corresponds to the ongoing revision (master branch in Github). See [https://eblondel.r-universe.dev/#package:rsdmx](https://eblondel.r-universe.dev/#package:rsdmx)

## Quickstart

[rsdmx](https://cran.r-project.org/package=rsdmx) offers a low-level set of tools to read **data** and **metadata** in SDMX format. Its strategy is to make it very easy for the user. For this, a unique function named ``readSDMX`` has to be used, whatever it is a ``data`` or ``metadata`` document, or if it is ``local`` or ``remote`` datasource.

It is important to highlight that one of the major benefits of ``rsdmx`` is to focus first on the SDMX **format** specifications (acting as format abstraction library). This allows ``rsdmx`` reading SDMX data from _remote_ datasources, or from _local_ SDMX files. For accessing _remote_ datasources, it also means that ``rsdmx`` does not bound to SDMX **service** specifications, and can read a wider ranger of datasources.


### Install rsdmx

``rsdmx`` can be installed from CRAN
```{r, echo = FALSE}
install.packages("rsdmx")
```

or from its development repository hosted in Github (using the ``devtools`` package):

```{r, echo = FALSE}
devtools::install_github("eblondel/rsdmx")
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
as.data.frame(providers)

```

#### create/add a SDMX service provider

It also also possible to create and add a new SDMX service providers in this list (so ``readSDMX`` can be aware of it). A provider can be created with the ``SDMXServiceProvider``, and is made of various parameters:
* ``agencyId`` (provider identifier)
* ``name``
* ``scale`` (international or national)
* ``country`` ISO 3-alpha code (if national)
* ``builder``

The request builder can be created with ``SDMXRequestBuilder`` which takes various arguments: 
* ``regUrl``: URL of the service registry endpoint
* ``repoUrl``: URL of the service repository endpoint (Note that we use 2 different
arguments for registry and repository endpoints, since some providers use different
URLs, but in most cases those are identical)
* ``formatter`` list of functions to format the request params (one function per
type of resource, e.g. "dataflow", "datastructure", "data")
* ``handler`` list of functions which will allow to build the web request
*``compliant`` logical parameter (either the request builder is compliant with some web-service specifications)

``rsdmx`` yet provides common builders, that can be customized if needed, by overriding
either the ``formatter`` or the ``handler`` functions:
* ``SDMXREST20RequestBuilder``: connector for SDMX REST 2.0 web-services
* ``SDMXREST21RequestBuilder``: connector for SDMX REST 2.1 web-services
* ``SDMXDotStatRequestBuilder``: connector for SDMX .Stat ("DotStat") web-services implementations

Let's see it with an example:

First create a request builder for our provider:

```{r, echo = FALSE}

myBuilder <- SDMXRequestBuilder(
  regUrl = "http://www.myorg.org/sdmx/registry",
  repoUrl = "http://www.myorg.org/sdmx/repository",
  formatter = list(
    dataflow = function(obj){
      #format each dataflow id with some prefix
      obj@resourceId <- paste0("df_",obj@resourceId)
      return(obj)
    },
    datastructure = function(obj){
      #do nothing
      return(obj)
    },
    data = function(obj){
      #format each dataset id with some prefix
      obj@flowRef <- paste0("data_",obj@flowRef)
      return(obj)
    }
  ),
  handler = list(
    dataflow = function(obj){
      req <- sprintf("%s/dataflow",obj@regUrl)
      return(req)
    },
    datastructure = function(obj){
      req <- sprintf("%s/datastructure",obj@regUrl)
      return(req)
    },
    data = function(obj){
      req <- sprintf("%s/data",obj@regUrl)
      return(req)
    }
  ),
  compliant = FALSE
)
```

As you can see, we built a custom ``SDMXRequestBuilder`` that will be able to 
create SDMX web-requests for the different resources of a SDMX web-service.

We can create a provider with the above request builder, and add it to the list 
of known SDMX service providers:

```{r, echo = FALSE}

#create the provider
provider <- SDMXServiceProvider(
agencyId = "MYORG",
name = "My Organization",
builder = myBuilder
)

#add it to the list
addSDMXServiceProvider(provider)

#check provider has been added
as.data.frame(getSDMXServiceProviders())


```

#### find a SDMX service provider

A another helper allows you to interrogate ``rsdmx`` if a specific provider is 
known, given an id:

```{r, echo = FALSE}
oecd <- findSDMXServiceProvider("OECD")
```

#### readSDMX as helper function

Now you know how to add a SDMX provider, you can consider using ``readSDMX`` 
without having to specifying a entire URL, but just by specifying the ``agencyId``
of the provider, and the different query parameters to reach your SDMX document:

```{r, echo = FALSE}
sdmx <- readSDMX(providerId = "MYORG", providerKey = NULL resource = "data", flowRef="MYSERIE",
                 key = "all", key.mode = "SDMX", start = 2000, end = 2015)
```

For embedded service providers that require a user authentication/subscription key or token,
it is possible to specify it in ``readSDMX`` with the ``providerKey`` argument. If provided,
and that the embedded provider requires a specific key parameter, the latter will be appended
to the SDMX web-request.



The following sections will show you how to query SDMX documents, by using ``readSDMX`` 
in different ways: either for _local_ or _remote_ files, using ``readSDMX`` as low-level 
or with the helpers (embedded service providers).

### Read dataset documents

This section will introduce you on how to read SDMX *dataset* documents.

#### Read _remote_ datasets


The following code snipet shows you how to read a dataset from a remote data source, taking as example the [OECD StatExtracts portal](https://data-explorer.oecd.org/): [https://sdmx.oecd.org/public/rest/data/DSD_PRICES@DF_PRICES_N_CP01/GRC......./all/?startPeriod=2020&endPeriod=2020](https://sdmx.oecd.org/public/rest/data/DSD_PRICES@DF_PRICES_N_CP01/GRC......./all/?startPeriod=2020&endPeriod=2020)

```{r, echo = FALSE}
myUrl <- "https://sdmx.oecd.org/public/rest/data/DSD_PRICES@DF_PRICES_N_CP01/GRC......./all/?startPeriod=2020&endPeriod=2020"
dataset <- readSDMX(myUrl)
stats <- as.data.frame(dataset) 
```

You can try it out with other datasources, such as:
* [**EUROSTAT portal**](https://ec.europa.eu/eurostat/web/main/home): [https://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/nama_10_gdp/.CLV10_MEUR.B1GQ.BE/?startperiod=2005&endPeriod=2011)
* [**European Central Bank (ECB)**](https://sdw-wsrest.ecb.europa.eu): [https://sdw-wsrest.ecb.europa.eu/service/data/DD/M.SE.BSI_STF.RO.4F_N](https://sdw-wsrest.ecb.europa.eu/service/data/DD/M.SE.BSI_STF.RO.4F_N)

The online rsdmx documentation also provides a list of data providers, either from international or national institutions.

Now, the service providers above mentioned are known by ``rsdmx`` which let users using ``readSDMX`` with the helper parameters. It may also be the case for a provider that
you register in rsdmx.

Let's see how it would look like for querying an ``OECD`` datasource:

```{r, message = FALSE}
sdmx <- readSDMX(providerId = "OECD", resource = "data", flowRef = "DSD_PRICES@DF_PRICES_N_CP01",
                 key = list("GRC", NULL, NULL, NULL, NULL, NULL, NULL, NULL), start = 2020, end = 2020)
df <- as.data.frame(sdmx)
head(df)
```

It is also possible to query a dataset together with its "definition", handled
in a separate SDMX-ML document named ``DataStructureDefinition`` (DSD). It is 
particularly useful when you want to enrich your dataset with all labels. For this, 
you need the DSD which contains all reference data.

To do so, you only need to append ``dsd = TRUE`` (default value is ``FALSE``), 
to the previous request, and specify ``labels = TRUE`` when calling ``as.data.frame``,
as follows:

```{r, message = FALSE}
sdmx <- readSDMX(providerId = "OECD", resource = "data", flowRef = "DSD_PRICES@DF_PRICES_N_CP01",
                 key = list("GRC", NULL, NULL, NULL, NULL, NULL, NULL, NULL), start = 2020, end = 2020,
                 dsd = TRUE)
df <- as.data.frame(sdmx, labels = TRUE)
head(df)
```

Note that in case you are reading SDMX-ML documents with the native approach (with
URLs), instead of the embedded providers, it is also possible to associate a DSD
to a dataset by using the function ``setDSD``. Let's try how it works:

```{r, message = FALSE}
#data without DSD
sdmx.data <- readSDMX(providerId = "OECD", resource = "data", flowRef = "DSD_PRICES@DF_PRICES_N_CP01",
                 key = list("GRC", NULL, NULL, NULL, NULL, NULL, NULL, NULL), start = 2020, end = 2020)

#DSD
sdmx.dsd <- readSDMX(providerId = "OECD", resource = "datastructure", resourceId = "DSD_PRICES")

#associate data and dsd
sdmx.data <- setDSD(sdmx.data, sdmx.dsd)
```



#### Read _local_ datasets

This example shows you how to use ``rsdmx`` with _local_ SDMX files, previously downloaded from [EUROSTAT](https://ec.europa.eu/eurostat).

```{r, echo = FALSE}
#bulk download from Eurostat
tf <- tempfile(tmpdir = tdir <- tempdir()) #temp file and folder
download.file("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Frd_e_gerdsc.sdmx.zip", tf)
sdmx_files <- unzip(tf, exdir = tdir)

sdmx <- readSDMX(sdmx_files[2], isURL = FALSE)
stats <- as.data.frame(sdmx)
head(stats)

```

By default, ``readSDMX`` considers the data source is remote. To read a local file, add ``isURL = FALSE``.

### Read metadata documents

This section will introduce you on how to read SDMX **metadata** complete ``data structure definitions`` (DSD)

```

#### Data Structure Definition (DSD)

This example illustrates how to read a complete DSD using a [OECD StatExtracts portal](https://data-explorer.oecd.org/) data source.

```{r, echo = FALSE}
dsdUrl <- "https://sdmx.oecd.org/public/rest/datastructure/all/DSD_PRICES/latest/?references=children"
dsd <- readSDMX(dsdUrl)
```

``rsdmx`` is implemented in object-oriented way with ``S4`` classes and methods. The properties of ``S4`` objects are named ``slots`` and can be accessed with the ``slot`` method. The following code snippet allows to extract the list of ``codelists`` contained in the DSD document, and read one codelist as ``data.frame``.

```{r, echo = FALSE}
#get codelists from DSD
cls <- slot(dsd, "codelists")
codelists <- sapply(slot(cls, "codelists"), function(x) slot(x, "id")) #get list of codelists
codelist <- as.data.frame(slot(dsd, "codelists"), codelistId = "CL_TRANSFORMATION") #get a codelist
```

In a similar way, the ``concepts`` of the dataset can be extracted from the DSD and read as ``data.frame``.

```{r, echo = FALSE}
#get concepts from DSD
concepts <- as.data.frame(slot(dsd, "concepts"))
```

### Save & Reload SDMX R objects

It is possible to save SDMX R objects as RData file (.RData, .rda, .rds), to then
be able to reload them into the R session. It could be of added value for users that
want to keep their SDMX objects in R data files, but also for fast loading of large SDMX
objects (e.g. DSD objects) for use in statistical analyses and R-based web-applications.

To save a SDMX R object to RData file:

```{r, echo = FALSE}
saveSDMX(sdmx, "tmp.RData")
```

To reload a SDMX R object from RData file:

```{r, echo = FALSE}
sdmx <- readSDMX("tmp.RData", isRData = TRUE)
```
