\name{SDMXSchema-class}
\docType{class}
\alias{SDMXSchema-class}
\alias{SDMXSchema}
\alias{SDMXSchema-method}


\title{Class "SDMXSchema"}
\description{ A basic class to handle the version of the SDMX-ML Schema}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
    \item{\code{version}}{Object of class "character" giving the SDMX-ML schema version}  
  }
}
\section{Methods}{
  \describe{
	\item{\code{getVersion}}{Retrieves the version of the SDMX-ML schema version}
  }
}

\usage{
SDMXSchema(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will 
encapsulate it as slot, when parsing an SDMX-ML document}

\keyword{classes}