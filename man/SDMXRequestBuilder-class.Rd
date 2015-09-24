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
    \item{\code{baseUrl}}{an object of class "character" giving the base Url of the SDMX service endpoint}
    \item{\code{suffix}}{an object of class "logical" indicating if the provider \code{agencyId} has to be used as suffix in the data web-request, before start/end url parameters} 
    \item{\code{handler}}{an object of class "function" that will be in charge of build a web request.} 
  }
}

\usage{
SDMXRequestBuilder(baseUrl, suffix, handler)
}

\arguments{
\item{baseUrl}{an object of class "character" giving the base Url of the SDMX service endpoint}
\item{suffix}{an object of class "logical" indicating if the provider \code{agencyId} has to be used as suffix in the data web-request, before start/end url parameters}
\item{handler}{an object of class "function" that will be in charge of build a web request.}
}

\details{

The \code{handler} function must have the following structure in term of arguments (baseUrl, operation, key, filter, suffix, 
start, end) and output (a string representing the web request to build).

The rsdmx package will as much as possible try to handler generic handlers, e.g. an handler for SDMX REST web-services.
For the latter example, a specific builder is provided and made part of the specific and still experimental \link{SDMXRESTRequestBuilder}.

}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #an handler
  myHandler <- function(baseUrl, agencyId, suffix, operation, key, filter, start, end){
    req <- paste(baseUrl, agencyId, operation, key, filter, start, end, sep="/")
    return(req)
  }
  
  #how to create a SDMXRequestBuilder
  requestBuilder <- SDMXRequestBuilder(
                      baseUrl = "http://www.myorg.",
                      suffix = TRUE,
                      handler = myHandler)
}
\keyword{classes}
\keyword{builder}
\keyword{request}