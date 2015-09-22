\name{setSDMXServiceProviders}
\Rdversion{1.1}
\alias{setSDMXServiceProviders}
\title{setSDMXServiceProviders}

\description{function used internally by \pkg{rsdmx}, when loading the package, to set the list of \link{SDMXServiceProvider} known by \pkg{rsdmx} (hence known by \link{readSDMX} to query data/metadata in an easier way). For internal use only (this function does not provide any value for the end user, but it is here documented for transparency, and to explain how the package works.)}

\usage{
setSDMXServiceProviders()
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}

\seealso{\link{getSDMXServiceProviders} \link{addSDMXServiceProvider} \link{findSDMXServiceProvider} \link{readSDMX}}