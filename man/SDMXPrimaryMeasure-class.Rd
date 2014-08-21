\name{SDMXPrimaryMeasure-class}
\docType{class}
\alias{SDMXPrimaryMeasure-class}
\alias{SDMXPrimaryMeasure}
\alias{SDMXPrimaryMeasure-method}

\title{Class "SDMXPrimaryMeasure"}
\description{ A basic class to handle a SDMX PrimaryMeasure}
\section{Objects from the Class}{are never to be generated; used by SDMX derived \link{SDMXComponents-class} class}
\section{Slots}{
  \describe{
    \item{\code{conceptRef}}{Object of class "character" giving the dimension conceptRef (required)}
    \item{\code{conceptVersion}}{Object of class "character" giving the dimension concept version}
    \item{\code{conceptAgency}}{Object of class "character" giving the dimension concept agency}
     \item{\code{conceptSchemeRef}}{Object of class "character" giving the dimension conceptScheme ref}
    \item{\code{conceptSchemeAgency}}{Object of class "character" giving the dimension conceptScheme agency}
    \item{\code{codelist}}{Object of class "character" giving the codelist ref name}
    \item{\code{codelistVersion}}{Object of class "character" giving the codelist ref version}
    \item{\code{codelistAgency}}{Object of class "character" giving the codelist ref agency}
  }
}

\usage{
  SDMXPrimaryMeasure(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or DataStructureDefinitions)}

\keyword{classes}