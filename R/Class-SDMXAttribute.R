#' @name SDMXAttribute
#' @docType class
#' @aliases SDMXAttribute-class
#' 
#' @title Class "SDMXAttribute"
#' @description A basic class to handle a SDMX Attribute
#' 
#' @slot conceptRef Object of class "character" giving the attribute conceptRef (required)
#' @slot conceptVersion Object of class "character" giving the attribute concept version
#' @slot conceptAgency Object of class "character" giving the attribute concept agency
#' @slot conceptSchemeRef Object of class "character" giving the attribute conceptScheme ref
#' @slot conceptSchemeAgency Object of class "character" giving the attribute conceptScheme agency
#' @slot codelist Object of class "character" giving the codelist ref name
#' @slot codelistVersion Object of class "character" giving the codelist ref version
#' @slot codelistAgency Object of class "character" giving the codelist ref agency
#' @slot attachmentLevel Object of class "character" giving the attachment level (e.g. DataSet)
#' @slot assignmentStatus Object of class "character" giving the assignment status (e.g. Mandatory)
#' @slot isTimeFormat Object of class "logical"
#' @slot crossSectionalAttachDataset Object of class "logical"
#' @slot crossSectionalAttachGroup Object of class "logical"
#' @slot crossSectionalAttachSection Object of class "logical"
#' @slot crossSectionalAttachObservation Object of class "logical"
#' @slot isEntityAttribute Object of class "logical" indicating if the Attribute is an entity Attribute. Default value is FALSE
#' @slot isNonObservationTimeAttribute Object of class "logical" indicating if the Attribute is a non-observation Attribute. Default value is FALSE
#' @slot isCountAttribute Object of class "logical" indicating if the Attribute is a count Attribute. Default value is FALSE
#' @slot isFrequencyAttribute Object of class "logical" indicating if the Attribute is a frequency Attribute. Default value is FALSE
#' @slot isIdentityAttribute Object of class "logical" indicating if the Attribute is an identity Attribute. Default value is FALSE
#' 
#' @section Warning:
#' This class is not useful in itself, but all SDMX non-abstract classes will 
#' encapsulate it as slot, when parsing an SDMX-ML document (DataStructures, or 
#' DataStructureDefinitions)
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' 
setClass("SDMXAttribute",
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
           attachmentLevel = "character", #required
           assignmentStatus = "character", #required
           isTimeFormat = "logical", #default to false
           crossSectionalAttachDataset = "logical", #optional
           crossSectionalAttachGroup = "logical", #optional
           crossSectionalAttachSection = "logical", #optional
           crossSectionalAttachObservation = "logical", #optional
           isEntityAttribute = "logical", #default to false
           isNonObservationTimeAttribute = "logical", #default to false
           isCountAttribute = "logical", #default to false
           isFrequencyAttribute = "logical", #default to false
           isIdentityAttribute = "logical" #default to false
           
           #elements
           #TextFormat = "SDMXTextFormat", #optional
           #AttachmentGroup = "list",
           #AttachmentMeasure = "list"
           
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
           attachmentLevel = "DataSet",
           assignmentStatus = "Mandatory",
           isTimeFormat = FALSE,
           crossSectionalAttachDataset = NA,
           crossSectionalAttachGroup = NA,
           crossSectionalAttachSection = NA,
           crossSectionalAttachObservation = NA,
           isEntityAttribute = FALSE,
           isNonObservationTimeAttribute = FALSE,
           isCountAttribute = FALSE,
           isFrequencyAttribute = FALSE,
           isIdentityAttribute = FALSE
           
           #elements
           #TextFormat = ?,
           #AttachmentGroup = ?,
           #AttachmentMeasure = ?
           
         ),
         validity = function(object){
           
           #eventual validation rules
           if(.rsdmx.options$validate){
             if(is.na(object@conceptRef)) return(FALSE)
             if(is.na(object@attachmentLevel)) return(FALSE)
             if(is.na(object@assignmentStatus)) return(FALSE)
           }
           
           return(TRUE);
         }
)
