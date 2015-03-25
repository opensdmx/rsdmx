\name{SDMXFooter-class}
\docType{class}
\alias{SDMXFooter-class}
\alias{SDMXFooter}
\alias{SDMXFooter-method}


\title{Class "SDMXFooter"}
\description{ A basic class to handle the footer of a SDMX-ML document}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
    \item{\code{messages}}{Object of class "SDMXFooterMessage" giving the list of messages}
  }
}

\usage{
SDMXFooter(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{
This class is especially useful for SDMX 2.1 compliant documents. Footer messages are not supported in SDMX 2.0
standard format. In this case, the footer will return an empty message list().

According to the SDMX 2.1 standard, the message severity takes one of the following values: "Error", "Warning",
"Information". Given the possible typos handled by data providers, rsdmx adopts a permissive strategy and does
not validate the object according to such controlled terms.
}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it 
as slot, when parsing an SDMX-ML document}

\keyword{classes}