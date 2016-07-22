#' @name SDMXHeader
#' @rdname SDMXHeader
#' @aliases SDMXHeader,SDMXHeader-method
#' 
#' @usage
#' SDMXHeader(xmlObj, namespaces)
#' 
#' @param xmlObj object of class "XMLInternalDocument derived from XML package
#' @param namespaces object of class "data.frame" given the list of namespace URIs
#' @return an object of class "SDMXHeader"
#' 
#' @seealso \link{readSDMX}
#'
SDMXHeader <- function(xmlObj, namespaces){

	sdmxVersion <- version.SDMXSchema(xmlObj, namespaces)
	VERSION.10 <- sdmxVersion == "1.0"
	VERSION.20 <- sdmxVersion == "2.0"
	VERSION.21 <- sdmxVersion == "2.1"
  
  	#header elements
	node <- xmlRoot(xmlObj)[[1]];
	children <- xmlChildren(node)
	
	#header attributes
	#-----------------
	id <- xmlValue(children$ID);
  	test <- FALSE
  	if(!is.null(children$Test))
  		test <- as.logical(xmlValue(children$Test));
		truncated <- FALSE
  	if(!is.null(children$Truncated))
    		truncated <- as.logical(xmlValue(children$Truncated));
		name <- xmlValue(children$Name);	
	
	#sender
	sender <- list(id=NA,name=NA,contact=NULL)
	if(!is.null(children$Sender)){
		sender$id <- xmlGetAttr(children$Sender,"id");
		senderList <- xmlChildren(children$Sender)
		if(length(senderList) != 0){
    			#name
			sender$name <- new.env()
    			senderNames <- senderList[names(senderList) == "Name"]
			sapply(senderNames,
				function(x) {
					if(xmlName(x) == "Name"){
        	 				lang <- xmlGetAttr(x,"xml:lang")
               					if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
               					if(is.null(lang)) lang <- "default"
               					sender$name[[lang]] <- xmlValue(x)
					}            
				})
			sender$name <- as.list(sender$name)
    
    			#contact
    			sender$contact <- NULL #TODO currently not implemented
		
    			#timezone
    			if(VERSION.21){
    				sender$timezone <- xmlValue(senderNames[["Timezone"]])
    			}
		}
	}
	
	#receiver
	receiver <- list(id=NA,name=NA,contact=NULL)
	if(!is.null(children$Receiver)){
		receiver$id <- xmlGetAttr(children$Receiver,"id");
		receiverList <- xmlChildren(children$Receiver)
		if(length(receiverList) != 0){
			#name
      			receiver$name <- new.env()
      			receiverNames <- receiverList[names(receiverList) == "Name"]
      			sapply(receiverNames, function(x) {
        			if(xmlName(x) == "Name"){
          				lang <- xmlGetAttr(x,"xml:lang")
          				if(is.null(lang)) lang <- xmlGetAttr(x,"lang")
          				if(is.null(lang)) lang <- "default"
          				receiver$name[[lang]] <- xmlValue(x)
        			}
      			})
      			receiver$name <- as.list(receiver$name)
      
      			#contact
      			sender$contact <- NULL #TODO currently not implemented
      
			#timezone
      			if(VERSION.21){
        			sender$timezone <- xmlValue(senderNames[["Timezone"]])
      			}
			
		}
	}
	
	#source
	source <- xmlValue(children$Source);
	
	#Dates
	preparedFormat <- NULL;
	prepared <- xmlValue(children$Prepared);
	if(!is.na(prepared)){
		if(nchar(prepared,"w") %in% c(4,10)){
      if(nchar(prepared,"w") == 4)
			  prepared <- ISOdate(as.integer(prepared),1,1)
			preparedFormat <- "%Y-%m-%d";
		}else{
			if(attr(regexpr("T", prepared),"match.length") != -1){
				preparedFormat <- "%Y-%m-%dT%H:%M:%S";
			}else{
				preparedFormat <- "%Y-%m-%d %H:%M:%S";
			}
		}
		prepared <- as.POSIXlt(strptime(prepared, format = preparedFormat));
	}else{
		prepared <- as.POSIXlt(NA)
	}
	
	extractedFormat <- NULL;
	extracted <- xmlValue(children$Extracted);
	if(!is.na(extracted)){
		if(nchar(extracted,"w") %in% c(4,10)){
      if(nchar(extracted,"w") == 4)
			  extracted <- ISOdate(as.integer(extracted),1,1)
			extractedFormat <- "%Y-%m-%d";
		}else{
			if(attr(regexpr("T", extracted),"match.length") != -1){
				extractedFormat <- "%Y-%m-%dT%H:%M:%S";
			}else{
				extractedFormat <- "%Y-%m-%d %H:%M:%S";
			}
		}
		extracted <- as.POSIXlt(strptime(extracted, format = extractedFormat));
	}else{
		extracted <- as.POSIXlt(NA)
	}
		
	#Reporting Dates
	reportFormat <- NULL;
	reportBegin = xmlValue(children$ReportingBegin)
	if(!is.na(reportBegin)){
		if(nchar(reportBegin,"w") %in% c(4,10)){
      if(nchar(reportBegin,"w") == 4)
			  reportBegin <- ISOdate(as.integer(reportBegin),1,1)
			reportFormat <- "%Y-%m-%d";
		}else{
			if(attr(regexpr("T", extracted),"match.length") != -1){
				reportFormat <- "%Y-%m-%dT%H:%M:%S";
			}else{
				reportFormat <- "%Y-%m-%d %H:%M:%S";
			}
		}
		reportBegin <- as.POSIXlt(strptime( reportBegin, format = reportFormat));
	}else{
		reportBegin <- as.POSIXlt(NA)
	}
	
	reportEnd = xmlValue(children$ReportingEnd)
	if(!is.na(reportEnd)){
		if(nchar(reportEnd,"w") == 4){
			reportEnd <- ISOdate(as.integer(reportEnd),12,31)
		}
		reportEnd <- as.POSIXlt(strptime( reportEnd, format = reportFormat));
	}else{
		reportEnd <- as.POSIXlt(NA)
	}
	
	#SDMXHeader object
	obj <- new("SDMXHeader",
				ID = id, Test = test, Truncated = truncated,
				Name = name, Sender = sender, Receiver = receiver,
				Prepared = prepared, Extracted = extracted,
				ReportingBegin = reportBegin, ReportingEnd = reportEnd,
				Source = source);

	return(obj);
}


