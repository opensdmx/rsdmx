\name{SDMXConcept-class}
\docType{class}
\alias{SDMXConcept-class}
\alias{SDMXConcept}
\alias{SDMXConcept-method}


\title{Class "SDMXConcept"}
\description{ A basic class to handle a SDMX Concept}
\section{Objects from the Class}{are never to be generated; used by SDMX derived  \link{SDMXConceptScheme-class} and \link{SDMXConcepts-class} classes}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID of the concept (required)}
    \item{\code{agencyID}}{Object of class "character" giving the AgencyID}
    \item{\code{version}}{Object of class "character" giving the concept version}
    \item{\code{uri}}{Object of class "character" giving the concept uri}
    \item{\code{urn}}{Object of class "character" giving the concept urn}
    \item{\code{isExternalReference}}{Object of class "logical" indicating if the concept is an external reference}
    \item{\code{coreRepresentation}}{Object of class "character" giving the core representation}
    \item{\code{coreRepresentationAgency}}{Object of class "character" giving the core representation agency}
    \item{\code{parent}}{Object of class "character" giving the concept parent}
    \item{\code{parentAgency}}{Object of class "character" giving the parentAgency}
    \item{\code{Name}}{Object of class "list" giving the concept name (by language) - required}
    \item{\code{Description}}{Object of class "list" giving the concept description (by language)}
}
}

\usage{
  SDMXConcept(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or
DataStructureDefinition)}

\keyword{classes}