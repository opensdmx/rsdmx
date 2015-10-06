\name{SDMXRequestBuilder-class}
\docType{class}
\alias{SDMXRequestBuilder-class}
\alias{SDMXRequestBuilder}
\alias{SDMXRequestBuilder-method}


\title{Class "SDMXRequestBuilder"}
\description{ A basic class to handle a SDMX service request builder}
\section{Objects from the Class}{will be used by the \link{SDMXServiceProvider}. This class may be useful for plugging a specific provider (where a specific \link{SDMXRequestBuilder} could be implemented. This class allows to provide an request "handler" (typically a function) that performs the SDMX web request build)}
\section{Slots}{
  \describe{
    \item{\code{regUrl}}{an object of class "character" giving the base Url of the SDMX service registry}
    \item{\code{repoUrl}}{an object of class "character" giving the base Url of the SDMX service repository}
    \item{\code{handler}}{an object of class "function" that will be in charge of build a web request.}
    \item{\code{compliant}}{an object of class "logical" indicating if the request builder is somehow compliant with a service specification} 
  }
}

\usage{
SDMXRequestBuilder(regUrl, repoUrl, handler, compliant)
}

\arguments{
    \item{regUrl}{an object of class "character" giving the base Url of the SDMX service registry}
    \item{repoUrl}{an object of class "character" giving the base Url of the SDMX service repository}
\item{handler}{an object of class "function" that will be in charge of build a web request.}
\item{compliant}{an object of class "logical" indicating if the request builder is somehow compliant with a service specification} 
}

\details{

The \code{handler} function must have the following structure in term of arguments (baseUrl, agencyId, resource, resourceId, version, flowRef, key, start, end, compliant) and output (a string representing the web request to build).

The rsdmx package will as much as possible try to handler generic handlers, e.g. an handler for SDMX REST web-services. For the latter example, a specific builder is provided and made part of the specific and still experimental \link{SDMXRESTRequestBuilder}.

}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #an handler
  myHandler <- function(baseUrl, agencyId, resource, resourceId, version,
                        flowRef, key, start, end, compliant){
    req <- paste(baseUrl, agencyId, resource, flowRef, key, start, end, sep="/")
    return(req)
  }
  
  #how to create a SDMXRequestBuilder
  requestBuilder <- SDMXRequestBuilder(
                      regUrl = "http://www.myorg.org/registry",
                      repoUrl = "http://www.myorg.org/repository",
                      handler = myHandler, compliant = FALSE)
}
\keyword{classes}
\keyword{builder}
\keyword{request}