\name{SDMXHeader-class}
\docType{class}
\alias{SDMXHeader-class}
\alias{SDMXHeader}
\alias{SDMXHeader-method}


\title{Class "SDMXHeader"}
\description{ A basic class to handle the header of a SDMX-ML document}
\section{Objects from the Class}{are never to be generated; used by SDMX derived classes}
\section{Slots}{
  \describe{
    \item{\code{ID}}{Object of class "character" giving the ID of the SDMX-ML document}
    \item{\code{Test}}{Object of class "logical" indicating if the SDMX-ML document is disseminated for test 
    purpose} 
    \item{\code{Truncated}}{Object of class "logical" indicating if the SDMX-ML document is truncated} 
    \item{\code{Name}}{Object of class "character" giving the name of SDMX-ML document} 
    \item{\code{Sender}}{Object of class "list" giving the id of the sender and eventually its in name, 
    possibly in multi-languages} 
     \item{\code{Receiver}}{Object of class "list" giving the id of the receiver and eventually its in name, 
    possibly in multi-languages} 
    \item{\code{Prepared}}{Object of class "POSIXlt" giving the preparation date of the SDMX-ML document}
    \item{\code{Extracted}}{Object of class "POSIXlt" giving the extraction date of the SDMX-ML document}
    \item{\code{ReportingBegin}}{Object of class "POSIXlt" giving the reporting begin date for the data 
    retrieved in the SDMX-ML document}
    \item{\code{ReportingEnd}}{Object of class "POSIXlt" giving the reporting end date for the data retrieved 
    in the SDMX-ML document}
    \item{\code{Source}}{Object of class "character" giving the source of the SDMX-ML document}     
  }
}

\usage{
SDMXHeader(xmlObj)
}

\arguments{
\item{xmlObj}{an object of class "XMLInternalDocument"}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\note{
Some SDMXHeader properties are not yet supported and thus not available as "slots". These are "KeyFamilyRef", 
"KeyFamilyAgency", "DataSetAgency", "DataSetID", "DataSetAction"
}

\section{Warning }{this class is not useful in itself, but all SDMX non-abstract classes will encapsulate it 
as slot, when parsing an SDMX-ML document}

\keyword{classes}