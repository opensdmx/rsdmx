\name{SDMX21RequestBuilder-class}
\docType{class}
\alias{SDMX21RequestBuilder-class}
\alias{SDMX21RequestBuilder}
\alias{SDMX21RequestBuilder-method}


\title{Class "SDMX21RequestBuilder"}
\description{ A basic class to handle a SDMX 2.1 service request builder}
\section{Objects from the Class}{will be used by a \link{SDMXServiceProvider} that implements the SDMX 2.1 web-service specifications. This class may be useful for plugging a new SDMX 2.1 service provider}
\section{Slots}{
  \describe{
    \item{\code{baseUrl}}{an object of class "character" giving the base Url of the SDMX service endpoint}
    \item{\code{suffix}}{an object of class "character" giving an url suffix to append, before start/end url parameters} 
  }
}

\usage{
SDMX21RequestBuilder(baseUrl, suffix)
}

\arguments{
\item{baseUrl}{an object of class "character" giving the base Url of the SDMX service endpoint}
\item{suffix}{an object of class "character" giving an url suffix to append, e.g. "service?", before start/end url parameters}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #how to create a SDMX21RequestBuilder
  requestBuilder <- SDMX21RequestBuilder(
                      baseUrl = "http://www.myorg.",
                      suffix = "service?")
}

\keyword{classes}
\keyword{builder}
\keyword{request}