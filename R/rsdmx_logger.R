#' rsdmxLogger
#'
#' @docType class
#' @export
#' @keywords logger
#' @return Object for modelling a simple logger
#'
#' @section Abstract Methods:
#' \describe{
#'  \item{\code{INFO(text)}}{
#'    Logger to report information. Used internally
#'  }
#'  \item{\code{WARN(text)}}{
#'    Logger to report warnings. Used internally
#'  }
#'  \item{\code{ERROR(text)}}{
#'    Logger to report errors. Used internally
#'  }
#' }
#' 
#' @note Logger class used internally by rsdmx
#' @export
#' 
rsdmxLogger <- R6Class("rsdmxLogger",
   private = list(
     enabled = FALSE,
     logger = function(type, text){
       if(private$enabled) cat(sprintf("[rsdmx][%s] %s \n", type, text))
     }
   ),
   public = list(
     #logger
     INFO = function(text){private$logger("INFO", text)},
     WARN = function(text){private$logger("WARN", text)},
     ERROR = function(text){private$logger("ERROR", text)},
     initialize = function(enabled = TRUE){
       private$enabled <- enabled
     }
   )
)