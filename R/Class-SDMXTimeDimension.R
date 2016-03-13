#' @name SDMXTimeDimension
#' @docType class
#' @aliases SDMXTimeDimension-class
#' 
#' @title Class "SDMXTimeDimension"
#' @description A basic class to handle a SDMX TimeDimension
#' 
#' @slot conceptRef Object of class "character" giving the dimension conceptRef (required)
#' @slot conceptVersion Object of class "character" giving the dimension concept version
#' @slot conceptAgency Object of class "character" giving the dimension concept agency
#' @slot conceptSchemeRef Object of class "character" giving the dimension conceptScheme ref
#' @slot conceptSchemeAgency Object of class "character" giving the dimension conceptScheme agency
#' @slot codelist Object of class "character" giving the codelist ref name
#' @slot codelistVersion Object of class "character" giving the codelist ref version
#' @slot codelistAgency Object of class "character" giving the codelist ref agency
#' @slot crossSectionalAttachDataset Object of class "logical"
#' @slot crossSectionalAttachGroup Object of class "logical"
#' @slot crossSectionalAttachSection Object of class "logical"
#' @slot crossSectionalAttachObservation Object of class "logical"
#'        
#' @section Warning:
#' This class is not useful in itself, but non-abstract classes willencapsulate 
#' it as slot, when parsing an SDMX-ML document (Concepts, or DataStructureDefinition) 
#'                    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXTimeDimension",
         representation(
           #attributes
           conceptRef = "character", #required
           conceptVersion = "character", #optional
           conceptAgency = "character", #optional
           conceptSchemeRef = "character", #optional
           conceptSchemeAgency = "character", #optional
           codelist = "character", #optional
           codelistVersion = "character", #optional
           codelistAgency = "character", #optional
           crossSectionalAttachDataset = "logical", #optional
           crossSectionalAttachGroup = "logical", #optional
           crossSectionalAttachSection = "logical", #optional
           crossSectionalAttachObservation = "logical" #optional
           
           #elements
           #TextFormat = "SDMXTextFormat" #optional
         ),
         prototype = list(
           #attributes
           conceptRef = "CONCEPT",
           conceptVersion = "1.0",
           conceptAgency = "ORG",
           conceptSchemeRef = "CONCEPT_SCHEME",
           conceptSchemeAgency = "ORG",
           codelist = "CODELIST",
           codelistVersion = "1.0",
           codelistAgency = "ORG",
           crossSectionalAttachDataset = NA,
           crossSectionalAttachGroup = NA,
           crossSectionalAttachSection = NA,
           crossSectionalAttachObservation = NA
           
           #elements
           #TextFormat = new("SDMXTextFormat")
         ),
         validity = function(object){
           
           #validation rules
           if(.rsdmx.options$validate){
             if(!is.null(object)){
               if(is.na(object@conceptRef)) return(FALSE)
             }
           }
           
           return(TRUE);
         }
)

setClassUnion("SDMXTimeDimension_OR_NULL", c("SDMXTimeDimension","NULL"))
