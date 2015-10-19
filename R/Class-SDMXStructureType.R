# E.Blondel - 2014/08/01
#=======================

#SDMX structureType class
setClass("SDMXStructureType",
         contains = "SDMXType",
         representation(subtype = "character"),
         prototype = list(),
         validity = function(object){
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
             warning(paste("Unknown SDMXStructureType '", type, "'", sep=""));
           
           return(valid);
         }
)
