\name{SDMXAttribute-class}
\docType{class}
\alias{SDMXAttribute-class}
\alias{SDMXAttribute}
\alias{SDMXAttribute-method}

\title{Class "SDMXAttribute"}
\description{ A basic class to handle a SDMX Attribute}
\section{Objects from the Class}{are never to be generated; used by SDMX derived \link{SDMXComponents-class} class}
\section{Slots}{
  \describe{
    \item{\code{conceptRef}}{Object of class "character" giving the attribute conceptRef (required)}
    \item{\code{conceptVersion}}{Object of class "character" giving the attribute concept version}
    \item{\code{conceptAgency}}{Object of class "character" giving the attribute concept agency}
     \item{\code{conceptSchemeRef}}{Object of class "character" giving the attribute conceptScheme ref}
    \item{\code{conceptSchemeAgency}}{Object of class "character" giving the attribute conceptScheme agency}
    \item{\code{codelist}}{Object of class "character" giving the codelist ref name}
    \item{\code{codelistVersion}}{Object of class "character" giving the codelist ref version}
    \item{\code{codelistAgency}}{Object of class "character" giving the codelist ref agency}
    \item{\code{attachmentLevel}}{Object of class "character" giving the attachment level (e.g. DataSet)}
    \item{\code{assignmentStatus}}{Object of class "character" giving the assignment status (e.g. Mandatory)}
    \item{\code{isTimeFormat}}{Object of class "logical"}
    \item{\code{crossSectionalAttachDataset}}{Object of class "logical"}
    \item{\code{crossSectionalAttachGroup}}{Object of class "logical"}
    \item{\code{crossSectionalAttachSection}}{Object of class "logical"}
    \item{\code{crossSectionalAttachObservation}}{Object of class "logical"} 
    \item{\code{isEntityAttribute}}{Object of class "logical" indicating if the Attribute is an entity Attribute. Default value is FALSE}
    \item{\code{isNonObservationTimeAttribute}}{Object of class "logical" indicating if the Attribute is a non-observation Attribute. Default value is FALSE}
    \item{\code{isCountAttribute}}{Object of class "logical" indicating if the Attribute is a count Attribute. Default value is FALSE}
    \item{\code{isFrequencyAttribute}}{Object of class "logical" indicating if the Attribute is a frequency Attribute. Default value is FALSE}
    \item{\code{isIdentityAttribute}}{Object of class "logical" indicating if the Attribute is an identity Attribute. Default value is FALSE}
  }
}

\usage{
  SDMXAttribute(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or DataStructureDefinitions)}

\keyword{classes}