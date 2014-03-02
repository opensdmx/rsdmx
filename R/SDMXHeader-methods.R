# rsdmx - SDMXHeader-methods
#
# Author: Emmanuel Blondel
#==========================

SDMXHeader <- function(xmlObj){

	#header elements
	node <- xmlRoot(xmlObj)[[1]];
	children <- xmlChildren(node)
	
	#header attributes
	#-----------------
	id <- xmlValue(children$ID);
	test <- as.logical(xmlValue(children$Test));
	if(is.null(test)) test <- FALSE;
	truncated <- as.logical(xmlValue(children$Truncated));
	name <- xmlValue(children$Name);	
	
	#sender
	sender <- new.env()
	sender$id <- xmlGetAttr(children$Sender,"id");
	senderNames <- xmlChildren(children$Sender)
	if(length(senderNames) == 0){
		sender$name <- NA
	}else{
		sender$name <- new.env()
		sapply(senderNames, function(x) {sender$name[[xmlGetAttr(x,"xml:lang")]] <- xmlValue(x)})
		sender$name <- as.list(sender$name)
	}
	sender <- as.list(sender)
	
	#receiver
	receiver <- list(id=NA,name=NA)
	if(!is.null(children$Receiver)){
		receiver <- new.env()
		receiver$id <- xmlGetAttr(children$Receiver,"id");
		receiverNames <- xmlChildren(children$Receiver)
		if(length(receiverNames) == 0){
			receiver$name <- NA
		}else{
			receiver$name <- new.env()
			sapply(receiverNames, function(x) {receiver$name[[xmlGetAttr(x,"xml:lang")]] <- xmlValue(x)})
			receiver$name <- as.list(receiver$name)
		}
		receiver <- as.list(receiver)
	}
	
	#source
	source <- xmlValue(children$Source);
	
	#Dates
	preparedFormat <- NULL;
	prepared <- xmlValue(children$Prepared);
	if(!is.na(prepared)){
		if(nchar(prepared) == 4){
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
		if(nchar(extracted) == 4){
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
		if(nchar(reportBegin) == 4){
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
		if(nchar(reportEnd) == 4){
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


