\name{SDMXConcepts-class}
\docType{class}
\alias{SDMXConcepts-class}
\alias{SDMXConcepts}
\alias{SDMXConcepts}


\title{Class "SDMXConcepts"}
\description{ A basic class to handle SDMX Concepts}
\section{Objects from the Class}{are never to be generated; used as target object by \link{readSDMX} (in case of conceptSchemes document), or intend to be used by SDMX derived classes like SDMXDataStructureDefinition (DSD)}
\section{Slots}{
  \describe{
    \item{\code{concepts}}{Object of class "list" giving the list of "SDMXConcept". This slot is available to ensure backward compatibility with SDMX 1.0 in SDMX 2.0 or 2.1 documents}
    \item{\code{conceptSchemes}}{Object of class "list" giving the list of "SDMXConceptScheme", which will encapsulate the list of "SDMXConcept" (defined from SDMX 2.0)}
}
}

\usage{
  SDMXConcepts(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}