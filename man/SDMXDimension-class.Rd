\name{SDMXDimension-class}
\docType{class}
\alias{SDMXDimension-class}
\alias{SDMXDimension}
\alias{SDMXDimension-method}

\title{Class "SDMXDimension"}
\description{ A basic class to handle a SDMX Dimension}
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
    \item{\code{isMeasureDimension}}{Object of class "logical" indicating if the dimension is a measure dimension. Default value is FALSE}
    \item{\code{isFrequencyDimension}}{Object of class "logical" indicating if the dimension is a frequency dimension. Default value is FALSE}
    \item{\code{isEntityDimension}}{Object of class "logical" indicating if the dimension is an entity dimension. Default value is FALSE}
    \item{\code{isCountDimension}}{Object of class "logical" indicating if the dimension is a count dimension. Default value is FALSE}
    \item{\code{isNonObservationTimeDimension}}{Object of class "logical" indicating if the dimension is a non-observation dimension. Default value is FALSE}
    \item{\code{isIdentityDimension}}{Object of class "logical" indicating if the dimension is an identity dimension. Default value is FALSE}
    \item{\code{crossSectionalAttachDataset}}{Object of class "logical"}
    \item{\code{crossSectionalAttachGroup}}{Object of class "logical"}
    \item{\code{crossSectionalAttachSection}}{Object of class "logical"}
    \item{\code{crossSectionalAttachObservation}}{Object of class "logical"}          
  }
}

\usage{
  SDMXDimension(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or DataStructureDefinitions)}

\keyword{classes}