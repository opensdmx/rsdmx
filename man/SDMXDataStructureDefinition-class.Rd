\name{SDMXDataStructureDefinition-class}
\docType{class}
\alias{SDMXDataStructureDefinition-class}
\alias{SDMXDataStructureDefinition}
\alias{SDMXDSD}
\alias{DSD}
\alias{SDMXDataStructureDefinition-method}
\title{Class "SDMXDataStructureDefinition"}
\description{ A basic class to handle a SDMX DataStructureDefinition (DSD)}
\section{Objects from the Class}{are never to be generated; retrieved by \link{readSDMX}}
\section{Slots}{
  \describe{
    \item{\code{concepts}}{Object of class "SDMXConcepts" giving the list of concepts or conceptSchemes (see \link{SDMXConcepts-class})}
    \item{\code{codelists}}{Object of class "SDMXCodelists" giving the list of codelists (see \link{SDMXCodelists-class})}
    \item{\code{datastructures}}{Object of class "SDMXDataStructures" giving the list of datastructures /key families (see \link{SDMXDataStructures-class})}
  }
}

\usage{
  SDMXDataStructureDefinition(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}