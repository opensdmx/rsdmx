\name{SDMXDataFlow-class}
\docType{class}
\alias{SDMXDataFlow-class}
\alias{SDMXDataFlow}
\alias{SDMXDataFlow-method}

\title{Class "SDMXDataFlow"}
\description{ A basic class to handle a SDMX DataFlow}
\section{Objects from the Class}{are never to be generated; used by SDMX derived  \link{SDMXDataFlows-class} classes}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID (required)}
    \item{\code{agencyID}}{Object of class "character" giving the AgencyID}
    \item{\code{version}}{Object of class "character" giving the version}
    \item{\code{uri}}{Object of class "character" giving the uri}
    \item{\code{urn}}{Object of class "character" giving the urn}
    \item{\code{isExternalReference}}{Object of class "logical" indicating if the dataflow is an external reference}
    \item{\code{isFinal}}{Object of class "logical" indicating if the dataflow is final}
    \item{\code{validFrom}}{Object of class "character" indicating the start validity period}
    \item{\code{validTo}}{Object of class "character" indicating the end validity period}
    \item{\code{Name}}{Object of class "list" giving the dataflow (by available language) - required}
    \item{\code{Description}}{Object of class "list" giving the dataflow description (by available language)}
    \item{\code{dsdRef}}{Object of class "character" giving the reference datastructure Id}
}
}

\usage{
  SDMXDataFlow(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}