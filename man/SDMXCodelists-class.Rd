\name{SDMXCodelists-class}
\docType{class}
\alias{SDMXCodelists-class}
\alias{SDMXCodelists}
\alias{SDMXCodelists}


\title{Class "SDMXCodelists"}
\description{ A basic class to handle SDMX Codelists}
\section{Objects from the Class}{are never to be generated; used as target object by \link{readSDMX} , or intend to be used by SDMX derived classes like SDMXDataStructureDefinition (DSD)}
\section{Slots}{
  \describe{
    \item{\code{codelists}}{Object of class "list" giving the list of "SDMXCodelist"}
}
}

\usage{
  SDMXCodelists(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}