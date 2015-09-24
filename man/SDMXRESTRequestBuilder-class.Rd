\name{SDMXRESTRequestBuilder-class}
\docType{class}
\alias{SDMXRESTRequestBuilder-class}
\alias{SDMXRESTRequestBuilder}
\alias{SDMXRESTRequestBuilder-method}


\title{Class "SDMXRESTRequestBuilder"}
\description{ A experimental class to handle a SDMX 2.1 service request builder}
\section{Objects from the Class}{will be used by a \link{SDMXServiceProvider} that provide SDMX REST web-service. This class may be useful for plugging a new SDMX service provider}
\section{Slots}{
  \describe{
    \item{\code{baseUrl}}{an object of class "character" giving the base Url of the SDMX service endpoint}
    \item{\code{suffix}}{an object of class "logical" indicating if the provider \code{agencyId} has to be used as suffix in the data web-request, before start/end url parameters. For some reasons, we noticed that some providers, e.g. UN-ILO were not authorizing to specify the \code{agencyId} as suffix.} 
  }
}

\usage{
SDMXRESTRequestBuilder(baseUrl, suffix)
}

\arguments{
\item{baseUrl}{an object of class "character" giving the base Url of the SDMX service endpoint}
\item{suffix}{an object of class "logical" indicating if the provider \code{agencyId} has to be used as suffix in the data web-request, before start/end url parameters}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #how to create a SDMXRESTRequestBuilder
  requestBuilder <- SDMXRESTRequestBuilder(baseUrl = "http://www.myorg", TRUE)
}

\keyword{classes}
\keyword{builder}
\keyword{request}