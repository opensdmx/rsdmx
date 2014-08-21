# E.Blondel - 2014/08/21
#=======================

#SDMX Attribute class
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
           if(is.na(object@conceptRef)) return(FALSE)
           #if(is.na(object@attachmentLevel)) return(FALSE)
           #if(is.na(object@assignmentStatus)) return(FALSE)
           return(TRUE);
         }
)
