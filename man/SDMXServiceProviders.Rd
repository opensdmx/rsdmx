% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Class-SDMXServiceProviders.R,
%   R/SDMXServiceProviders-methods.R
\docType{class}
\name{SDMXServiceProviders}
\alias{SDMXServiceProviders}
\alias{SDMXServiceProviders-class}
\alias{SDMXServiceProviders,SDMXServiceProviders-method}
\title{Class "SDMXServiceProviders"}
\usage{
SDMXServiceProviders(providers)
}
\arguments{
\item{providers}{an object of class "list" (of \link{SDMXServiceProvider}) 
configured by default and/or at runtime in \pkg{rsdmx}}
}
\value{
an object of class "SDMXServiceProviders"
}
\description{
A class to wrap a list of SDMX service providers
}
\section{Slots}{

\describe{
\item{\code{providers}}{an object of class "list" (of \link{SDMXServiceProvider}) 
configured by default and/or at runtime in \pkg{rsdmx}}
}}

\section{Warning}{

this class is not useful in itself, but all SDMX non-abstract classes will 
encapsulate it as slot, when parsing an SDMX-ML document.
}

\author{
Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}
}
