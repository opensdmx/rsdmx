\name{findNamespace}
\Rdversion{1.1}
\alias{findNamespace}
\title{findNamespace}

\description{function used to find a specific namespace within the available namespaces of an SDMX-ML object}

\usage{
findNamespace(namespaces, messageType)
}

\arguments{
  \item{namespaces}{A \code{data.frame} giving the id and uri of namespaces available in a SDMX-ML object, typically obtained with \link{getNamespaces}}
  \item{messageType}{a \code{character} representing a message type}
}

\value{an object of class "character" giving the namespace uri if found in the
available namespaces}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{findNamespace} is a function used internally as utility
function in SDMX-ML object parsers.}

\seealso{\link{SDMX-class} \link{getNamespaces}}