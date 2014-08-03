\name{type.SDMXStructureType}
\Rdversion{1.1}
\alias{type.SDMXStructureType}
\title{type.SDMXStructureType}

\description{function used to parse the structure type of an SDMX-ML object}

\usage{
type.SDMXStructureType(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\value{an object of class "character"}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{type.SDMXStructureType} is a function used internally to parse the SDMX structure type
during instantiation of SDMX objects }

\seealso{\link{SDMXStructureType-class}}