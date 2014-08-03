\name{getNamespaces-methods}
\docType{methods}
\alias{getNamespaces,SDMX-method}
\alias{getNamespaces}
\title{getNamespaces}
\description{Access the namespaces of the SDMX-ML object}

\usage{
getNamespaces(obj)
}

\arguments{
  \item{obj}{An object deriving from class "SDMX"}
}

\section{Methods}{
\describe{
	\item{obj}{An object deriving from class "SDMX"}
}}

\value{an \code{data.frame} giving the id and uri for each of the namespaces
handled in the SDMX-ML document.}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{methods}

\seealso{\link{SDMX-class}}
