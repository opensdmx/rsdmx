\name{SDMXDataStructure-class}
\docType{class}
\alias{SDMXDataStructure-class}
\alias{SDMXDataStructure}
\alias{SDMXDataStructure-method}

\title{Class "SDMXDataStructure"}
\description{ A basic class to handle a SDMX DataStructure (or KeyFamily)}
\section{Objects from the Class}{are never to be generated; used by SDMX derived  \link{SDMXCodelists-class} classes}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID (required)}
    \item{\code{agencyID}}{Object of class "character" giving the AgencyID}
    \item{\code{version}}{Object of class "character" giving the version}
    \item{\code{uri}}{Object of class "character" giving the uri}
    \item{\code{urn}}{Object of class "character" giving the urn}
    \item{\code{isExternalReference}}{Object of class "logical" indicating if the datastructure / keyfamily is an external reference}
    \item{\code{isFinal}}{Object of class "logical" indicating if the datastructure / keyfamily is final}
    \item{\code{validFrom}}{Object of class "character" indicating the start validity period}
    \item{\code{validTo}}{Object of class "character" indicating the end validity period}
    \item{\code{Name}}{Object of class "list" giving the codelist (by language) - required}
    \item{\code{Description}}{Object of class "list" giving the codelist description (by language)}
    \item{\code{Components}}{Object of class "SDMXComponents" (see \link{SDMXComponents-class})}
}
}

\usage{
  SDMXDataStructure(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{This class is named according to SDMX 2.1 specifications. The SDMX 2.0 KeyFamily type is handled with this unique class, the 'DataStucture' being the new term for 'KeyFamily'}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or DataStructureDefinition)}

\keyword{classes}