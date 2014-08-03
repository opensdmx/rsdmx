\name{SDMXType-class}
\docType{class}
\alias{SDMXType-class}
\alias{SDMXType}
\alias{SDMXType-method}


\title{Class "SDMXType"}
\description{ A basic class to handle the type of a SDMX-ML document}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
    \item{\code{type}}{Object of class "character" giving the type of the SDMX-ML document}   
  }
}
\section{Methods}{
	\describe{
		\item{\code{getType}}{Returns the type of the SDMX-ML document}
	}
}

\usage{
SDMXType(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{
At now, the following types have been implemented and tested: \code{GenericDataType}, \code{CompactDataType}, and {MessageGroupType}. At now the \code{MessageGroupType} was only modeled to allow reading OECD generic data which is provided. Other message types handled in \code{MessageGroup} document type are not yet supported.
}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate itas slot, when parsing an SDMX-ML document}

\keyword{classes}