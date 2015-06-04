\name{getSoapRequestResult}
\Rdversion{1.1}
\alias{getSoapRequestResult}
\title{getSoapRequestResult}

\description{function used to extract the SDMX-ML message from a SOAP request response}

\usage{
getSoapRequestResult(xmlObj)
}

\arguments{
  \item{xmlObj}{object of class "XMLInternalDocument derived from XML package}
}

\value{an object of class "XMLInternalDocument derived from XML package}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{getSoapRequestResult} is a function used internally by \link{readSDMX}}

\seealso{\link{SDMX-class} \link{readSDMX}}