\name{findSDMXServiceProvider}
\Rdversion{1.1}
\alias{findSDMXServiceProvider}
\title{findSDMXServiceProvider}

\description{function that allows searching by provider id in the list of known \link{SDMXServiceProvider}. This function can be used for interrogating the list of default providers known by \pkg{rsdmx}, and is used internally by \link{readSDMX}}

\usage{
findSDMXServiceProvider(id)
}

\arguments{
\item{id}{an object of class "character" representing a provider identifier}
}

\value{an object of class "SDMXServiceProvider" (or NULL if no matching)}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #find OECD provider
  oecd.provider <- findSDMXServiceProvider("OECD")

}

\seealso{\link{getSDMXServiceProviders} \link{findSDMXServiceProvider} \link{readSDMX}}