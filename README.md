**rsdmx**
=======
[![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)
[![codecov.io](http://codecov.io/github/opensdmx/rsdmx/coverage.svg?branch=master)](http://codecov.io/github/opensdmx/rsdmx?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rsdmx)](http://cran.r-project.org/web/packages/rsdmx)

```rsdmx``: Tools  for reading SDMX data and metadata documents in R

## Overview

``rsdmx`` is a package to parse/read SDMX data and metadata in R. It provides a set of classes and methods to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML). [Learn more](https://github.com/opensdmx/rsdmx/wiki#package_overview).

**Citation**: We thank in advance people that use ``rsdmx`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.11551.png)](http://dx.doi.org/10.5281/zenodo.11551)

**Fundings**
 ``rsdmx`` is looking for **[sponsors](https://github.com/opensdmx/rsdmx/wiki#package_development_funding) !!** Please help us to make the package growing!

**Status**
At now, the package allows to read:
* Datasets (``GenericData``, ``CompactData``, ``StructureSpecificData``, ``UtilityData`` and ``MessageGroup`` SDMX-ML types)
* Concepts (``Concept``, ``ConceptScheme`` and ``Concepts`` SDMX-ML types)
* Codelists (``Code``, ``Codelist`` and ``Codelists`` SDMX-ML types)
* DataStructures / KeyFamilies - with all subtypes
* Data Structure Definitions (DSDs) - with all subtypes

It has been tested on all SDMX standard format versions ``1.0``, ``2.0`` and ``2.1``
 
**R CRAN rsdmx check results:**

[http://cran.r-project.org/web/checks/check_results_rsdmx.html](http://cran.r-project.org/web/checks/check_results_rsdmx.html)

Please note that following a new submission to CRAN, or eventually a modification of CRAN policies, the package might be temporarily archived, and removed from CRAN. In case you notice that the package is not back in few time, please contact me.

**Mailing list:<br/>**
[https://groups.google.com/forum/#!forum/rsdmx](https://groups.google.com/forum/#!forum/rsdmx)<br/>
You can subscribe directly in the google group, or by email: [rsdmx+subscribe@googlegroups.com](rsdmx+subscribe@googlegroups.com)
To send a post, use: [rsdmx@googlegroups.com](rsdmx@googlegroups.com)
To unsubscribe, send an email to: [rsdmx+unsubscribe@googlegroups.com](rsdmx+unsubscribe@googlegroups.com)

## Quickstart

[rsdmx](http://cran.r-project.org/web/packages/rsdmx/index.html) offers a low-level set of tools to read **data** and **metadata** in SDMX format. Its strategy is to make it very easy for the user. For this, a unique function named ``readSDMX`` has to be used, whatever it is a ``data`` or ``metadata`` document, or if it is ``local`` or ``remote`` datasource.


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

### Read dataset documents

This section will introduce you on how to read SDMX *dataset* documents, either from remote datasources, or from local SDMX files.

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

The online rsdmx documentation also provides a list of data providers, either from international or national institutions.

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
