\name{attributes.SDMXComponents}
\Rdversion{1.1}
\alias{attributes.SDMXComponents}
\title{attributes.SDMXComponents}

\description{function used to parse the list of 'attribute' components of a SDMX-ML documents}

\usage{
  attributes.SDMXComponents(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{attributes.SDMXComponents} is a function used internally to parse the list of attributes during instantiation of "SDMXComponents" objects (used in DataStructures / KeyFamilies)}

\seealso{\link{SDMXComponents-class} \link{SDMXDataStructure-class}}