\name{SDMXServiceProviders-class}
\docType{class}
\alias{SDMXServiceProviders-class}
\alias{SDMXServiceProviders}
\alias{SDMXServiceProviders-method}


\title{Class "SDMXServiceProviders"}
\description{A class to wrap a list of SDMX service providers}
\section{Objects from the Class}{are used internally by \pkg{rsdmx} to configure a list of default/well-known SDMX service providers, that are made available to \link{readSDMX}, and then allow users to query directly their SDMX service endpoint without having to specify the entire web request URLs.}
\section{Slots}{
  \describe{
    \item{\code{providers}}{an object of class "list" (of \link{SDMXServiceProvider}) configured by default and/or at runtime in \pkg{rsdmx}}
  }
}

\usage{
SDMXServiceProviders(providers)
}

\arguments{
  \item{providers}{an object of class "list" (of \link{SDMXServiceProvider}) configured by default and/or at runtime in \pkg{rsdmx}}
}

\author{ Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\keyword{classes}
\keyword{provider}