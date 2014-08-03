\name{namespaces.SDMX}
\Rdversion{1.1}
\alias{namespaces.SDMX}
\title{namespaces.SDMX}

\description{function used to get the namespaces handled by an SDMX-ML object}

\usage{
namespaces.SDMX(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\value{an object of class "data.frame" giving the namespace(s) id and uri}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning}{\code{namespaces.SDMX} is a function used internally to get the
namespaces of the SDMX-ML object through \link{getNamespaces}. This last function
is used an utility re-used in the different SDMX document parsers.}

\seealso{\link{SDMXType-class} \link{getNamespaces}}