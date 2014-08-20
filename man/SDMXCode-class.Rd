\name{SDMXCode-class}
\docType{class}
\alias{SDMXCode-class}
\alias{SDMXCode}
\alias{SDMXCode-method}

\title{Class "SDMXCode"}
\description{ A basic class to handle a SDMX Code}
\section{Objects from the Class}{are never to be generated; used by SDMX derived class \link{SDMXCodelists-class}}
\section{Slots}{
  \describe{
    \item{\code{id}}{Object of class "character" giving the ID of the code (required). In SDMX 2.0 documents, this slot will handle the 'value' attribute}
    \item{\code{urn}}{Object of class "character" giving the code urn}
    \item{\code{parentCode}}{Object of class "character" giving the parent code}
    \item{\code{label}}{Object of class "list" giving the code label (by language). In SDMX 2.0, it takes the code 'Description' element vs. 'Name' element in SDMX 2.1}
}
}

\usage{
  SDMXCode(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (Codelists, or DataStructureDefinition)}

\keyword{classes}