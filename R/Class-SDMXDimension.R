# E.Blondel - 2014/08/20
#=======================

#SDMX Components class
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
