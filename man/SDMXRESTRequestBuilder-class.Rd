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
    \item{\code{regUrl}}{an object of class "character" giving the base Url of the SDMX service registry}
    \item{\code{repoUrl}}{an object of class "character" giving the base Url of the SDMX service repository}
    \item{\code{compliant}}{an object of class "logical" indicating if the web-service is compliant with the SDMX REST web-service specifications} 
  }
}

\usage{
SDMXRESTRequestBuilder(regUrl, repoUrl, compliant)
}

\arguments{
  \item{regUrl}{an object of class "character" giving the base Url of the SDMX service registry}
  \item{repoUrl}{an object of class "character" giving the base Url of the SDMX service repository}
  \item{compliant}{an object of class "logical" indicating if the web-service is compliant with the SDMX REST web-service specifications} 
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #how to create a SDMXRESTRequestBuilder
  requestBuilder <- SDMXRESTRequestBuilder(
                      regUrl = "http://www.myorg/registry",
                      repoUrl = "http://www.myorg/repository",
                      compliant = TRUE)
}

\keyword{classes}
\keyword{builder}
\keyword{request}