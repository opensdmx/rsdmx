\name{isSoapRequestEnvelope}
\Rdversion{1.1}
\alias{isSoapRequestEnvelope}
\title{isSoapRequestEnvelope}

\description{function used to detect if the XML document corresponds to a SOAP request response}

\usage{
isSoapRequestEnvelope(xmlObj)
}

\arguments{
  \item{xmlObj}{object of class "XMLInternalDocument derived from XML package}
}

\value{an object of class "logical"}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{isSoapRequestEnvelope} is a function used internally by \link{readSDMX}}

\seealso{\link{SDMX-class} \link{readSDMX}}