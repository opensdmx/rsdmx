\name{type.SDMXType}
\Rdversion{1.1}
\alias{type.SDMXType}
\title{type.SDMXType}

\description{function used to parse the type of an SDMX-ML object}

\usage{
type.SDMXType(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\value{an object of class "character"}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{type.SDMXType} is a function used internally to parse the SDMX type
during instantiation of SDMX objects }

\seealso{\link{SDMXType-class} \link{getSDMXType}}