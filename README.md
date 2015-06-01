**rsdmx**
=======
[![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)

```rsdmx``: Tools  for reading SDMX data and metadata documents in R

## Overview

``rsdmx`` is a package to parse/read SDMX data and metadata in R. It provides a set of classes and methods to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML). [Learn more](https://github.com/opensdmx/rsdmx/wiki#package_overview).

**Citation**: We thank in advance people that use ``rsdmx`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.11551.png)](http://dx.doi.org/10.5281/zenodo.11551)

**Fundings**
 ``rsdmx`` is looking for **[sponsors](https://github.com/opensdmx/rsdmx/wiki#package_development_funding) !!** Please help us to make the package growing!

**Status**
At now, the package allows to read:
* Datasets (``GenericData``, ``CompactData``, ``UtilityData`` and ``MessageGroup`` SDMX-ML types)
* Concepts (``Concept``, ``ConceptScheme`` and ``Concepts`` SDMX-ML types)
* Codelists (``Code``, ``Codelist`` and ``Codelists`` SDMX-ML types)
* DataStructures / KeyFamilies - with all subtypes
* Data Structure Definitions (DSDs) - with all subtypes

It has been tested mainly on SDMX standard versions ``2.0`` and ``2.1``, and in a less extent on version ``1.0``
 
**R CRAN rsdmx check results:**

[http://cran.r-project.org/web/checks/check_results_rsdmx.html](http://cran.r-project.org/web/checks/check_results_rsdmx.html)

Please note that following a new submission to CRAN, or eventually a modification of CRAN policies, the package might be temporarily archived, and removed from CRAN. In case you notice that the package is not back in few time, please contact me.

**Mailing list:<br/>**
[https://groups.google.com/forum/#!forum/rsdmx](https://groups.google.com/forum/#!forum/rsdmx)<br/>
You can subscribe directly in the google group, or by email: [rsdmx+subscribe@googlegroups.com](rsdmx+subscribe@googlegroups.com)
To send a post, use: [rsdmx@googlegroups.com](rsdmx@googlegroups.com)
To unsubscribe, send an email to: [rsdmx+unsubscribe@googlegroups.com](rsdmx+unsubscribe@googlegroups.com)

## Quickstart

### Install

Stable version from CRAN

```r
install.packages("rsdmx")
```
Or development version from GitHub.

```r
devtools::install_github("opensdmx/rsdmx")
```

```r
library("rsdmx")
```

### Use cases

#### Read SDMX-ML **data** documents

```r
dataURL <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MIG/TOT../OECD?startTime=2000&endTime=2011"
sdmx <- readSDMX(dataURL)
stats <- as.data.frame(sdmx)
head(stats)
```

#### Read SDMX-ML **metadata** documents

```r
dsdUrl <- "http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/TABLE1"
dsd <- readSDMX(dsdUrl)

#get codelists from DSD
cls <- slot(dsd, "codelists")
codelists <- sapply(slot(cls, "codelists"), function(x) slot(x, "id")) #get list of codelists
codelist <- as.data.frame(slot(dsd, "codelists"), codelistId = "CL_TABLE1_FLOWS") #get a codelist

#get concepts from DSD
concepts <- as.data.frame(slot(dsd, "concepts"))
```
