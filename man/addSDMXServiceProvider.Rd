\name{addSDMXServiceProvider}
\Rdversion{1.1}
\alias{addSDMXServiceProvider}
\title{addSDMXServiceProvider}

\description{function that allows configuring a new \link{SDMXServiceProvider} as part of the list of providers known by \pkg{rsdmx}, hence by \link{readSDMX}}

\usage{
addSDMXServiceProvider(provider)
}

\arguments{
\item{provider}{an object of class "SDMXServiceProvider"}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

  #create a provider
  myBuilder <- SDMX21RequestBuilder(baseUrl = "http://www.myorg.", suffix = "service?")
  myProvider <- SDMXServiceProvider(id = "MYORG", name = "My Organization", builder = myBuilder)

  #add it
  addSDMXServiceProvider(myProvider)
  
  #check out the list of existing provider (only list the ids)
  sapply(getSDMXServiceProviders(), function(x){slot(x, "id")})

}

\seealso{\link{getSDMXServiceProviders} \link{findSDMXServiceProvider} \link{readSDMX}}