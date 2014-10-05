\name{class.SDMXMessageGroup}
\Rdversion{1.1}
\alias{class.SDMXMessageGroup}
\title{class.SDMXMessageGroup}

\description{function used to determine the wrapped object class of a SDMX-ML 
MessageGroup object}

\usage{
class.SDMXMessageGroup(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\value{an object of class "character"}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\section{Warning }{\code{class.SDMXMessageGroup} is a function used internally to
determine appropriate methods to be used for SDMXMessageGroup objects. At now, the
function has been tested to distinguish between embedded dataset objects, either
SDMXGenericData or SDMXCompactData, and used to call appropriate \code{as.data.frame}
method}

\seealso{\link{SDMXMessageGroup-class}}