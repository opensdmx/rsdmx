\name{dimensions.SDMXComponents}
\Rdversion{1.1}
\alias{dimensions.SDMXComponents}
\title{dimensions.SDMXComponents}

\description{function used to parse the list of 'dimension' components of a SDMX-ML documents}

\usage{
  dimensions.SDMXComponents(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{dimensions.SDMXComponents} is a function used internally to parse the list of dimensions during instantiation of "SDMXComponents" objects (used in DataStructures / KeyFamilies)}

\seealso{\link{SDMXComponents-class} \link{SDMXDataStructure-class}}