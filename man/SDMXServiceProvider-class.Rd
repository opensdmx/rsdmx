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
    \item{\code{agencyId}}{an object of class "character" giving the a provider identifier}
    \item{\code{name}}{an object of class "character" giving the name of the provider}
    \item{\code{scale}}{an object of class "character" giving the scale of the datasource, either "international" or "national"}
    \item{\code{country}}{an object of class "character" giving the ISO 3-alpha code of the country (if scale is "national")}
    \item{\code{builder}}{an object of class "SDMXRequestBuilder" that will performs the web request building}
  }
}

\usage{
SDMXServiceProvider(agencyId, name, scale, country, builder)
}

\arguments{
\item{agencyId}{an object of class "character" giving the a provider identifier}
\item{name}{an object of class "character" giving the name of the provider}
\item{scale}{an object of class "character" giving the scale of the datasource, either "international" or "national". Default value is "international".}
\item{country}{an object of class "character" giving the ISO 3-alpha code of the country (if scale is "national"). Default value is \code{NA}}
\item{builder}{an object of class "SDMXRequestBuilder" that will performs the web request building for this specific provider}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #let's create a SDMXRESTRequestBuilder
  #(assuming that "My Organization" implements SDMX REST web-services)
  myBuilder <- SDMXRESTRequestBuilder(baseUrl = "http://www.myorg.org", compliant = TRUE)
                      
  #create a SDMXServiceProvider
  provider <- SDMXServiceProvider(agencyId = "MYORG", name = "My Organization",
                                  builder = myBuilder)
}

\keyword{classes}
\keyword{provider}