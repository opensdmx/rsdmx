\name{SDMXFooterMessage-class}
\docType{class}
\alias{SDMXFooterMessage-class}
\alias{SDMXFooterMessage}
\alias{SDMXFooterMessage-method}


\title{Class "SDMXFooterMessage"}
\description{ A basic class to handle a footer message of a SDMX-ML document}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
    \item{\code{code}}{Object of class "character" giving the status code}
    \item{\code{severity}}{Object of class "character" giving the severity of the message}
    \item{\code{messages}}{Object of class "list" giving the list of messages}
  }
}

\usage{
SDMXFooterMessage(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{
This class is especially useful for SDMX 2.1 compliant documents. Footer messages are not supported in SDMX 2.0
standard format.

According to the SDMX 2.1 standard, the message severity takes one of the following values: "Error", "Warning",
"Information". Given the possible typos handled by data providers, rsdmx adopts a permissive strategy and does
not validate the object according to such controlled terms.
}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it 
as slot, when parsing an SDMX-ML document}

\keyword{classes}