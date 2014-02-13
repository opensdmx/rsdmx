# rsdmx - SDMXHeader-methods
#
# Author: Emmanuel Blondel
#==========================

SDMXHeader <- function(xmlObj){

	#header elements
	node <- getNodeSet(xmlObj, "//message:Header");
	p <- as.data.frame(sapply(node, function(x) (sapply(xmlChildren(x), function(x) xmlValue(x)))));
	p[,1] <- as(p[,1], "character");
	
	#header attributes
	id <- p["ID",];
	test <- as.logical(p["Test",]);
	if(is.null(test)) test <- FALSE;
	truncated <- as.logical(p["Truncated",]);
	name <- p["Name",];

	
	sender <- "NA";
	senderNode <- getNodeSet(xmlDoc(node[[1]]), "//message:Sender");
	if(length(senderNode) > 0) sender <- xmlGetAttr(getNodeSet(xmlDoc(node[[1]]), "//message:Sender")[[1]],"id");
	receiver <- "NA"
	receiverNode <- getNodeSet(xmlDoc(node[[1]]), "//message:Receiver");
	if(length(receiverNode) > 0) receiver <- xmlGetAttr(getNodeSet(xmlDoc(node[[1]]), "//message:Receiver")[[1]], "id");
	
	source <- p["Source",];
	
	#Dates
	preparedFormat <- NULL;
	prepared <- p["Prepared",];
	if(!is.null(prepared)){
		if(regexpr("T", prepared) != 1){
			preparedFormat <- "%Y-%m-%d %H:%M:%S";
		}else{
			if(nchar(prepared) == 4){
				prepared <- ISOdate(as.integer(prepared),1,1)
				preparedFormat <- "%Y-%m-%d";
			}else{
				preparedFormat <- "%Y-%m-%dT%H:%M:%S";
			}
		}
		prepared <- as.POSIXlt(strptime(prepared, format = preparedFormat));
	}
	#extractedFormat <- NULL;
	#extracted <- p["Extracted",];
	#if(!is.na(extracted)){
	#	if(regexpr("T", extracted) != 1){
	#		extractedFormat <- "%Y-%m-%d %H:%M:%S";
	#	}else{
	#		extractedFormat <- "%Y-%m-%dT%H:%M:%S";
	#	}
	#	extracted <- as.POSIXlt(strptime(extracted, format = extractedFormat));
	#}
		
	#Reporting Dates
	#beginFormat <- NULL;
	#reportBegin = p["ReportingBegin",];
	#if(!is.na(reportBegin)){
	#	if(regexpr("T", reportBegin) != 1){
	#		beginFormat <- "%Y-%m-%d %H:%M:%S";
	#	}else{
	#		if(nchar(reportBegin) == 4){
	#			reportBegin <- ISOdate(as.integer(reportBegin),1,1)
	#			beginFormat <- "%Y-%m-%d";
	#		}else{
	#			beginFormat <- "%Y-%m-%dT%H:%M:%S";
	#		}
	#	}
	#}
	#reportBegin <- as.POSIXlt(strptime( reportBegin, format = beginFormat));
	
	#endFormat <- NULL;
	#reportEnd = p["ReportingEnd",];
	#if(!is.na(reportEnd)){
	#	if(regexpr("T", reportEnd) != 1){
	#		endFormat <- "%Y-%m-%d %H:%M:%S";
	#	}else{
	#		if(nchar(reportEnd) == 4){
	#			reportEnd <- ISOdate(as.integer(reportEnd),12,31)
	#			endFormat <- "%Y-%m-%d";
	#		}else{
	#			endFormat <- "%Y-%m-%dT%H:%M:%S";
	#		}
	#	}
	#}
	#reportEnd <- as.POSIXlt(strptime( reportEnd, format = endFormat));
	
	
	#SDMXHeader object
	obj <- new("SDMXHeader",
				ID = id, Test = test, Truncated = truncated,
				Name = name, Sender = sender, Receiver = receiver,
				Prepared = prepared,
				#Extracted = extracted,
				#ReportingBegin = reportBegin, ReportingEnd = reportEnd,
				Source = source);

	return(obj);
}


