#' @name SDMXStructureType
#' @docType class
#' @aliases SDMXStructureType-class
#' 
#' @title Class "SDMXStructureType"
#' @description A basic class to handle the type of a SDMX-ML Structure document
#' 
#' @section Warning:
#' This class is not useful in itself, but it will be used by \link{readSDMX} to
#' deal with SDMX-ML Structure documents.
#'    
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#'
setClass("SDMXStructureType",
         contains = "SDMXType",
         representation(subtype = "character"),
         prototype = list(),
         validity = function(object){
           
           #validation rules
           if(.rsdmx.options$validate){
             type <- getStructureType(object);
             valid <- switch(type,
                             "DataflowsType" = TRUE,
                             "ConceptsType" = TRUE,
                             "CodelistsType" = TRUE,
                             "DataStructuresType" = TRUE,
                             "DataStructureDefinitionsType" = TRUE,
                             FALSE
             );
             if(valid == FALSE)
               warning(paste0("Unknown SDMXStructureType '", type, "'"));
             
             return(valid);
           }
           
           return(TRUE);
         }
)
