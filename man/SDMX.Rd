\name{SDMX}
\Rdversion{1.1}
\alias{SDMX}

\title{SDMX}

\description{create objects of class \code{SDMX}}

\usage{
SDMX(xmlObj)
}

\arguments{
\item{xmlObj}{object of class "XMLInternalDocument derived from XML package}
}

\value{Returns an object of class "SDMX"}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{SDMX} function is used as internal constructor by \code{readSDMX}
to instantiate SDMX objects. This function should not be used.}

\seealso{\link{SDMX-class} \link{readSDMX}}
