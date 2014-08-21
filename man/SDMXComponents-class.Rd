\name{SDMXComponents-class}
\docType{class}
\alias{SDMXComponents-class}
\alias{SDMXComponents}
\alias{SDMXComponents-method}

\title{Class "SDMXComponents"}
\description{ A basic class to handle SDMX Components}
\section{Objects from the Class}{are never to be generated; used by SDMX derived \link{SDMXDataStructure-class} class}
\section{Slots}{
  \describe{
    \item{\code{Dimensions}}{Object of class "list" giving the list of dimensions (see \link{SDMXDimension-class})}
    \item{\code{TimeDimension}}{Object of class "SDMXTimeDimension"}
    \item{\code{PrimaryMeasure}}{Object of class "SDMXPrimaryMeasure"}
     \item{\code{Attributes}}{Object of class "list" giving the list of attributes (see \link{SDMXAttribute-class})}
   
  }
}

\usage{
  SDMXComponents(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or DataStructureDefinitions)}

\keyword{classes}