\name{getSDMXServiceProviders}
\Rdversion{1.1}
\alias{getSDMXServiceProviders}
\title{getSDMXServiceProviders}

\description{function used to get the list of \link{SDMXServiceProvider} known by \pkg{rsdmx} (hence known by \link{readSDMX} to query data/metadata in an easier way). This function can be easily used to interrogate the list of known providers, and eventually consider
adding one at runtime with \link{addSDMXServiceProvider}}

\usage{
getSDMXServiceProviders()
}

\value{an object of class "list" (of \link{SDMXServiceProvider})}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\seealso{\link{addSDMXServiceProvider} \link{findSDMXServiceProvider} \link{readSDMX}}