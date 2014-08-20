\name{SDMXConceptScheme-class}
\docType{class}
\alias{SDMXConceptScheme-class}
\alias{SDMXConceptScheme}
\alias{SDMXConceptScheme-method}


\title{Class "SDMXConceptScheme"}
\description{ A basic class to handle a SDMX Concept scheme}
\section{Objects from the Class}{are never to be generated; used by SDMX derived  \link{SDMXConcepts-class} classes}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID of the concept scheme (required)}
    \item{\code{agencyID}}{Object of class "character" giving the AgencyID}
    \item{\code{version}}{Object of class "character" giving the version}
    \item{\code{uri}}{Object of class "character" giving the concept uri}
    \item{\code{urn}}{Object of class "character" giving the concept urn}
    \item{\code{isExternalReference}}{Object of class "logical" indicating if the concept scheme is an external reference}
    \item{\code{isFinal}}{Object of class "logical" indicating if the concept scheme is final}
    \item{\code{validFrom}}{Object of class "character" indicating the start validity period}
    \item{\code{validTo}}{Object of class "character" indicating the end validity period}
    \item{\code{Name}}{Object of class "list" giving the concept scheme name (by language) - required}
    \item{\code{Description}}{Object of class "list" giving the concept scheme description (by language)}
    \item{\code{Concept}}{Object of class "list" giving the list of "SDMXConcept" objects (see \link{SDMXConcept-class})}
}
}

\usage{
  SDMXConceptScheme(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or
DataStructureDefinition)}

\keyword{classes}