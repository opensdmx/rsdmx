\name{SDMXServiceProvider-class}
\docType{class}
\alias{SDMXServiceProvider-class}
\alias{SDMXServiceProvider}
\alias{SDMXServiceProvider-method}


\title{Class "SDMXServiceProvider"}
\description{ A basic class to handle a SDMX service provider}
\section{Objects from the Class}{are used by \pkg{rsdmx} to configure a list of default/well-known SDMX service providers, that are made available to \link{readSDMX}, and then allow users to query directly their SDMX service endpoint without having to specify the entire web request URLs.}
\section{Slots}{
  \describe{
    \item{\code{id}}{an object of class "character" giving the a provider identifier}
    \item{\code{name}}{an object of class "character" giving the name of the provider}
    \item{\code{builder}}{an object of class "SDMXRequestBuilder" that will performs the web request building}
  }
}

\usage{
SDMXServiceProvider(id, name, builder)
}

\arguments{
\item{id}{an object of class "character" giving the a provider identifier}
\item{name}{an object of class "character" giving the name of the provider}
\item{builder}{an object of class "SDMXRequestBuilder" that will performs the web request building for this specific provider}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #let's create a SDMX21RequestBuilder
  #(assuming that "My Organization" implements SDMX 2.1 web-service specifications)
  myBuilder <- SDMX21RequestBuilder(baseUrl = "http://www.myorg.", suffix = "service?")
                      
  #create a SDMXServiceProvider
  provider <- SDMXServiceProvider(id = "MYORG", name = "My Organization", builder = myBuilder)
}

\keyword{classes}
\keyword{provider}