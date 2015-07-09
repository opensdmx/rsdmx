# E.Blondel - 2014/08/21
#=======================

#SDMX TimeDimension class
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
           
           #eventual validation rules
           if(!is.null(object)){
             if(is.na(object@conceptRef)) return(FALSE)
           }
           
           return(TRUE);
         }
)

setClassUnion("SDMXTimeDimension_OR_NULL", c("SDMXTimeDimension","NULL"))
