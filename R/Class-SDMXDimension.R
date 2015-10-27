#' @name SDMXDimension
#' @docType class
#' @aliases SDMXDimension-class
#' 
#' @title Class "SDMXDimension"
#' @description A basic class to handle a SDMX Dimension
#'
#' @slot conceptRef Object of class "character" giving the dimension conceptRef (required)
#' @slot conceptVersion Object of class "character" giving the dimension concept version
#' @slot conceptAgency Object of class "character" giving the dimension concept agency
#' @slot conceptSchemeRef Object of class "character" giving the dimension conceptScheme ref
#' @slot conceptSchemeAgency Object of class "character" giving the dimension conceptScheme agency
#' @slot codelist Object of class "character" giving the codelist ref name
#' @slot codelistVersion Object of class "character" giving the codelist ref version
#' @slot codelistAgency Object of class "character" giving the codelist ref agency
#' @slot isMeasureDimension Object of class "logical" indicating if the dimension is a measure dimension. Default value is FALSE
#' @slot isFrequencyDimension Object of class "logical" indicating if the dimension is a frequency dimension. Default value is FALSE
#' @slot isEntityDimension Object of class "logical" indicating if the dimension is an entity dimension. Default value is FALSE
#' @slot isCountDimension Object of class "logical" indicating if the dimension is a count dimension. Default value is FALSE
#' @slot isNonObservationTimeDimension Object of class "logical" indicating if the dimension is a non-observation dimension. Default value is FALSE
#' @slot isIdentityDimension Object of class "logical" indicating if the dimension is an identity dimension. Default value is FALSE
#' @slot crossSectionalAttachDataset Object of class "logical"
#' @slot crossSectionalAttachGroup Object of class "logical"
#' @slot crossSectionalAttachSection Object of class "logical"
#' @slot crossSectionalAttachObservation Object of class "logical"         
#'
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (Concepts, or 
#' DataStructureDefinition)
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXDimension",
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
          isMeasureDimension = "logical", #default to false
          isFrequencyDimension = "logical", #default to false
          isEntityDimension = "logical", #default to false
          isCountDimension = "logical", #default to false
          isNonObservationTimeDimension = "logical", #default to false
          isIdentityDimension = "logical", #default to false
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
          isMeasureDimension = FALSE,
          isFrequencyDimension = FALSE,
          isEntityDimension = FALSE,
          isCountDimension = FALSE,
          isNonObservationTimeDimension = FALSE,
          isIdentityDimension = FALSE,
          crossSectionalAttachDataset = NA,
          crossSectionalAttachGroup = NA,
          crossSectionalAttachSection = NA,
          crossSectionalAttachObservation = NA
          
          #elements
          #TextFormat = new("SDMXTextFormat")
          
         ),
         validity = function(object){
           #eventual validation rules
           #if(is.na(object@conceptRef)) return(FALSE)
           return(TRUE);
         }
)
