\name{SDMXDataFlows-class}
\docType{class}
\alias{SDMXDataFlows-class}
\alias{SDMXDataFlows}
\alias{SDMXDataFlows-method}

\title{Class "SDMXDataFlows"}
\description{ A basic class to handle a SDMX DataFlows}
\section{Objects from the Class}{are never to be generated; retrieved by \link{readSDMX} for DataFlows documents}
\section{Slots}{
  \describe{
    \item{\code{dataflows}}{Object of class "list" giving the list of DataFlows (datasets), (see \link{SDMXDataFlow-class})}   
  }
}

\usage{
  SDMXDataFlows(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}