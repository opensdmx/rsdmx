\name{concepts.SDMXConcepts}
\Rdversion{1.1}
\alias{concepts.SDMXConcepts}
\title{concepts.SDMXConcepts}

\description{function used to parse the list of concepts of a SDMX-ML documents, to ensure backward compability with SDMX 1.0 that does not handle concepts in a concept scheme}

\usage{
  concepts.SDMXConcepts(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{concepts.SDMXConcepts} is a function used internally to parse the list of concepts during instantiation of "SDMXConcepts" objects}

\seealso{\link{SDMXConcepts-class} \link{SDMXConcept-class}}