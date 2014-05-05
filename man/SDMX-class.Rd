\name{SDMX-class}
\docType{class}
\alias{SDMX-class}
\alias{SDMX-method}


\title{Class "SDMX"}
\description{ An abstract class from which SDMX classes are derived}
\section{Objects from the Class}{are never to be generated; only derived classes can be meaningful}
\section{Slots}{
  \describe{
    \item{\code{xmlObj}}{Object of class "XMLInternalDocument" derived from XML package}  
    \item{\code{schema}}{Object of class "SDMXSchema" which handles the version of SDMX-ML implementation}
    \item{\code{header}}{Object of class "SDMXHeader"}
  }
}
\section{Methods}{
  \describe{
	\item{as.XML}{\code{signature(obj = "SDMX")}: Retrieves the object of class "XMLInternalDocument derived from XML package}
	\item{\code{getSDMXSchema}}{\code{signature(obj = "SDMX")}: Get the SDMX-ML schema version}
	\item{\code{getSDMXHeader}}{\code{signature(obj = "SDMX")}: Get the SDMX header object}
	\item{\code{getSDMXType}}{\code{signature(obj = "SDMX")}: Get an object of class "SDMXType"}
  }
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{
Currently, the approach drafted in \link{rsdmx} package was to rely on XML package, read the xml object and store it as part of the SDMX R object.
Another approach being investigated is to use XML handlers that could avoid to load the entire XML tree in the SDMX R object (xmlObj). Indeed, 
SDMX data could be huge and causes issues of memory if the complete XML tree is loaded in the R user session.
}

\section{Warning }{this class is not useful in itself, but all SDMX classes in this package derive from it }

\keyword{classes}