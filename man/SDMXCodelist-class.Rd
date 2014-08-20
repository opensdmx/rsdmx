\name{SDMXCodelist-class}
\docType{class}
\alias{SDMXCodelist-class}
\alias{SDMXCodelist}
\alias{SDMXCodelist-method}

\title{Class "SDMXCodelist"}
\description{ A basic class to handle a SDMX Codelist}
\section{Objects from the Class}{are never to be generated; used by SDMX derived  \link{SDMXCodelists-class} classes}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID of the codelist (required)}
    \item{\code{agencyID}}{Object of class "character" giving the AgencyID}
    \item{\code{version}}{Object of class "character" giving the version}
    \item{\code{uri}}{Object of class "character" giving the codelist uri}
    \item{\code{urn}}{Object of class "character" giving the codelist urn}
    \item{\code{isExternalReference}}{Object of class "logical" indicating if the codelist is an external reference}
    \item{\code{isFinal}}{Object of class "logical" indicating if the codelist is final}
    \item{\code{validFrom}}{Object of class "character" indicating the start validity period}
    \item{\code{validTo}}{Object of class "character" indicating the end validity period}
    \item{\code{Name}}{Object of class "list" giving the codelist (by language) - required}
    \item{\code{Description}}{Object of class "list" giving the codelist description (by language)}
    \item{\code{Code}}{Object of class "list" giving the list of "SDMXCode" objects included in the codelist (see \link{SDMXCode-class})}
}
}

\usage{
  SDMXCodelist(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (Codelists, or DataStructureDefinition)}

\keyword{classes}