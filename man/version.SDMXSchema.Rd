\name{version.SDMXSchema}
\Rdversion{1.1}
\alias{version.SDMXSchema}
\title{version.SDMXSchema}

\description{function used to parse the schema of an SDMX-ML object}

\usage{
version.SDMXSchema(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{version.SDMXSchema} is a function used internally to parse the SDMX schema
during instantiation of SDMX objects}

\seealso{\link{SDMXSchema-class} \link{getSDMXSchema}}