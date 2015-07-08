# E.Blondel - 2013/06/10
#=======================

# function to read SDMX as character string
# (required in order to encapsulate a S3 old class object in a S4 representation)
readSDMX <- function(file, isURL = TRUE){
	
	#load data
	status <- 0
	if(isURL == FALSE){
		if(!file.exists(file))
			stop("File ", file, "not found\n")
		xmlObj <- xmlTreeParse(file, useInternalNodes = TRUE)
    		status <- 1
	}else{
		rsdmxAgent <- paste("rsdmx/",as.character(packageVersion("rsdmx")),sep="")
		content <- getURL(file, httpheader = list('User-Agent' = rsdmxAgent),
                      ssl.verifypeer = FALSE, .encoding = "UTF-8")
    
		status <- tryCatch({
			if(attr(regexpr("<!DOCTYPE html>", content), "match.length") == -1){
        
			        #check the presence of a BOM
			        BOM <- "\ufeff"
			        if(attr(regexpr(BOM, content), "match.length") != - 1){
			          content <- gsub(BOM, "", content)
			        }
        
			        xmlObj <- xmlTreeParse(content, useInternalNodes = TRUE)
			        status <- 1
			}else{
				stop("The SDMX web-request failed. Please retry")
		      	}
		},error = function(err){
			print(err)
			status <<- 0
			return(status)
		})
	}
  
  	#internal function for SDMX Structure-based document
	getSDMXStructureObject <- function(xmlObj){
		strTypeObj <- SDMXStructureType(xmlObj)
		strType <- getStructureType(strTypeObj)
		strObj <- switch(strType,
			"ConceptsType" = SDMXConcepts(xmlObj),
	  		"CodelistsType" = SDMXCodelists(xmlObj),
	  		"DataStructuresType" = SDMXDataStructures(xmlObj),
	  		"DataStructureDefinitionsType" = SDMXDataStructureDefinition(xmlObj),
	  		NULL
	  	)
	  	return(strObj)
	}  
	
	#encapsulate in S4 object
	obj <- NULL
	if(status){ 
    
	    	#convenience for SDMX documents embedded in SOAP XML responses
		if(isSoapRequestEnvelope(xmlObj)){
			xmlObj <- getSoapRequestResult(xmlObj)
		}
	    
		type <- SDMXType(xmlObj)@type
		obj <- switch(type,
			"StructureType"             = getSDMXStructureObject(xmlObj),
			"GenericDataType"           = SDMXGenericData(xmlObj),
			"CompactDataType"           = SDMXCompactData(xmlObj),
			"UtilityDataType"           = SDMXUtilityData(xmlObj),
			"StructureSpecificDataType" = SDMXStructureSpecificData(xmlObj),
			"MessageGroupType"          = SDMXMessageGroup(xmlObj),
			NULL
		) 
	
	  	if(is.null(obj)){
	    		if(type == "StructureType"){
	      			strTypeObj <- SDMXStructureType(xmlObj)
	      			type <- getStructureType(strTypeObj)
	    		}
			stop(paste("Unsupported SDMX Type '",type,"'",sep=""))
	      
		}else{
	      
	      		#handling footer messages
	      		footer <- slot(obj, "footer")
	      		footer.msg <- slot(footer, "messages") 
	      		if(length(footer.msg) > 0){
			        invisible(
			          lapply(footer.msg,
			          	function(x){
			          		code <- slot(x,"code")
			          		severity <- slot(x,"severity")
			          		lapply(slot(x,"messages"),
			          			function(msg){
			          				warning(paste(severity," (Code ",code,"): ",msg,sep=""),
			          					call. = FALSE)
			                          	}
						)
			                 })	
				)
	      		}
		}
  	}
	return(obj);
}
