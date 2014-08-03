\name{SDMXStructureType-class}
\docType{class}
\alias{SDMXStructureType-class}
\alias{SDMXStructureType}
\alias{SDMXStructureType-method}


\title{Class "SDMXStructureType"}
\description{ A basic abstract class to handle the type of a SDMX-ML structure document}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
	\item{\code{type}}{Object of class "character giving the super type "SDMXStructure"}
    \item{\code{subtype}}{Object of class "character" giving the structure type of the SDMX-ML document}   
  }
}
\section{Methods}{
	\describe{
		\item{\code{getStructureType}}{Returns the structure type of the SDMX-ML document}
	}
}

\usage{
SDMXStructureType(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}