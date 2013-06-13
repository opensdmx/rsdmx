# E.Blondel - 2013/06/09
#=======================

SDMXHeader <- function(xmlObj){
	
	#header values
	node <- getNodeSet(xmlObj, "//message:Header");
	p <- as.data.frame(sapply(node, function(x) (sapply(xmlChildren(x), function(x) xmlValue(x)))));
	p[,1] <- as(p[,1], "character");
	
	#header attributes
	Sender <- xmlGetAttr(getNodeSet(xmlDoc(node[[1]]), "//message:Sender")[[1]],"id");
	
	#SDMXHeader object
	obj <- new("SDMXHeader",
				ID = p["ID",],
				Test = as.logical(p["Test",]),
				Prepared = strptime(p["Prepared",], format = "%Y-%m-%dT%H:%M:%S"),
				Sender = Sender);
	
	type <- SDMXType(xmlObj)@type;	
	if(type == "SDMXDataSet"){
		obj <- new("SDMXDataSetHeader",
			obj,
			ReportingBegin = p["ReportingBegin",],
			ReportingEnd = p["ReportingEnd",]);
	}
	
	return(obj);
}


