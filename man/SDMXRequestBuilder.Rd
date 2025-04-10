% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Class-SDMXRequestBuilder.R,
%   R/SDMXRequestBuilder-methods.R
\docType{class}
\name{SDMXRequestBuilder}
\alias{SDMXRequestBuilder}
\alias{SDMXRequestBuilder-class}
\alias{SDMXRequestBuilder,SDMXRequestBuilder-method}
\title{Class "SDMXRequestBuilder"}
\usage{
SDMXRequestBuilder(regUrl, repoUrl, accessKey = NULL,
  formatter, handler, compliant, unsupportedResources = list(), 
  headers = list())
}
\arguments{
\item{regUrl}{an object of class "character" giving the base Url of the SDMX service registry}

\item{repoUrl}{an object of class "character" giving the base Url of the SDMX service repository}

\item{accessKey}{an object of class "character" indicating the name of request parameter for which
an authentication or subscription user key/token has to be provided to perform requests}

\item{formatter}{an object of class "list" giving a formatting function (for each resource) that
takes an object of class "SDMXRequestParams" as single argument. Such parameter allows
to customize eventual params (e.g. specific data provider rules)}

\item{handler}{an object of class "list" that will be in charge of build a web request.}

\item{compliant}{an object of class "logical" indicating if the request builder is somehow compliant with a service specification}

\item{unsupportedResources}{an object of class "list" giving one or more resources not
supported by the Request builder for a given provider}

\item{headers}{an object of class "list" that contains any additional headers for the request.}
}
\description{
A basic class to handle a SDMX service request builder
}
\details{
The \code{handler} function will list the resource methods. Each method will accept a
single object of class \code{\link{SDMXRequestParams}} as argument. This object will
give the different request params as slots (baseUrl, agencyId, resource, resourceId,
version, flowRef, key, start, end, compliant) to build the output (a string representing 
the web request to build).

The rsdmx package will as much as possible try to handler generic handlers. At now,
the available embedded builders are:
\link{SDMXREST20RequestBuilder} (connector for SDMX 2.0 web-services),
\link{SDMXREST21RequestBuilder} (connector for SDMX 2.1 web-services),
\link{SDMXDotStatRequestBuilder} (connector for SDMX .Stat web-services implementations)
}
\section{Slots}{

\describe{
\item{\code{regUrl}}{an object of class "character" giving the base Url of the SDMX service registry}

\item{\code{repoUrl}}{an object of class "character" giving the base Url of the SDMX service repository}

\item{\code{accessKey}}{an object of class "character" indicating the name of request parameter for which
an authentication or subscription user key/token has to be provided to perform requests}

\item{\code{formatter}}{an object of class "list" giving a formatting function (for each resource) that
takes an object of class "SDMXRequestParams" as single argument. Such parameter allows
to customize eventual params (e.g. specific data provider rules)}

\item{\code{handler}}{an object of class "list" that will be in charge of build a web request.}

\item{\code{compliant}}{an object of class "logical" indicating if the request builder is somehow compliant with a service specification}

\item{\code{unsupportedResources}}{an object of class "character" giving one or more resources not
supported by the Request builder for a given provider}

\item{\code{headers}}{an object of class "list" that contains any additional headers for the request.}
}}

\section{Warning}{

This class is not useful in itself, but all SDMX non-abstract classes will 
encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
DataStructureDefinition)
}

\examples{
 #default formatter
 myFormatter = list(
   dataflow = function(obj){
     #format some obj slots here
     return(obj)
   },
   datastructure = function(obj){
     #format some obj slots here
     return(obj)
   },
   data = function(obj){
     #format some obj slots here
     return(obj)
   }
 )

 #an handler
 #where each element of the list is a function taking as argument an object
 #of class "SDMXRequestParams"
 myHandler <- list(
   "dataflow" = function(obj){return(obj@regUrl)},
   "datastructure" = function(obj){return(obj@regUrl)},
   "data" = function(obj){return(obj@repoUrl)}
 )
 
 #how to create a SDMXRequestBuilder
 requestBuilder <- SDMXRequestBuilder(
   regUrl = "http://www.myorg.org/registry",
   repoUrl = "http://www.myorg.org/repository",
   accessKey = NULL,
   formatter = myFormatter, handler = myHandler, compliant = FALSE)
}
\author{
Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}
}
