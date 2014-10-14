rsdmx
=======

R package to read SDMX data and metadata

 ``rsdmx`` is looking for **[sponsors](https://github.com/opensdmx/rsdmx/wiki#package_development_funding) !!** Please help us to make the package growing!

============================

``rsdmx`` is a package to parse/read SDMX data and metadata in R. It provides a set of classes and methods to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML).

At now, the package allows to read:
* Datasets (``GenericData``, ``CompactData`` and ``MessageGroup`` SDMX-ML types)
* Concepts (``Concept``, ``ConceptScheme`` and ``Concepts`` SDMX-ML types)
* Codelists (``Code``, ``Codelist`` and ``Codelists`` SDMX-ML types)
* DataStructures / KeyFamilies
* Data Structure Definitions (DSDs)
 
**R package build tests:**

branch | build status
-------|-------------
master | [![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=master)
0.3 | [![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.3)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.3)
0.2 | [![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.2)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.2)
0.1 | [![Build Status](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.1)](https://travis-ci.org/opensdmx/rsdmx.svg?branch=0.1)

**R CRAN rsdmx check results:**

[http://cran.r-project.org/web/checks/check_results_rsdmx.html](http://cran.r-project.org/web/checks/check_results_rsdmx.html)

Please note that following a new submission to CRAN, or eventually a modification of CRAN policies, the package might be temporarily archived, and removed from CRAN. In case you notice that the package is not back in few time, please contact me.

**Mailing lists:<br/>**
* Users<br/>
[https://groups.google.com/forum/#!forum/rsdmx](https://groups.google.com/forum/#!forum/rsdmx)<br/>
You can subscribe directly in the google group, or by email: [rsdmx+subscribe@googlegroups.com](rsdmx+subscribe@googlegroups.com)
To send a post, use: [rsdmx@googlegroups.com](rsdmx@googlegroups.com)
To unsubscribe, send an email to: [rsdmx+unsubscribe@googlegroups.com](rsdmx+unsubscribe@googlegroups.com)

* Package developments<br/>
[https://groups.google.com/forum/#!forum/rsdmx-dev](https://groups.google.com/forum/#!forum/rsdmx-dev)<br/>
You can subscribe directly in the google group, or by email: [rsdmx-dev+subscribe@googlegroups.com](rsdmx-dev+subscribe@googlegroups.com)
To send a post, use: [rsdmx-dev@googlegroups.com](rsdmx-dev@googlegroups.com)
To unsubscribe, send an email to: [rsdmx-dev+unsubscribe@googlegroups.com](rsdmx-dev+unsubscribe@googlegroups.com)
