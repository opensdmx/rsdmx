\name{SDMXDataStructures-class}
\docType{class}
\alias{SDMXDataStructures-class}
\alias{SDMXDataStructures}
\alias{SDMXDataStructures-method}

\title{Class "SDMXDataStructures"}
\description{ A basic class to handle a SDMX DataStructures (or KeyFamilies)}
\section{Objects from the Class}{are never to be generated; retrieved by \link{readSDMX} for DataStructures documents, or as part of a DataStructureDefinitions (DSD)}
\section{Slots}{
  \describe{
    \item{\code{datastructures}}{Object of class "list" giving the list of DataStructures, (see \link{SDMXDataStructure-class})}   
  }
}

\usage{
  SDMXDataStructures(xmlObj)
}

\arguments{
  \item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{This class is named according to SDMX 2.1 specifications. The SDMX 2.0 KeyFamilies type is handled with this unique class, the 'DataStuctures' being the new term for 'KeyFamilies'}

\keyword{classes}