# E.Blondel - 2013/06/10
#=======================

SDMXDataSet <- function(xmlObj){
	sdmx <- SDMX(xmlObj);
	new("SDMXDataSet",
		SDMX(xmlObj)
		)		
}

#methods
as.data.frame.SDMXDataSet <- function(x, ...){
	xmlObj <- x@xmlObj;

	#tag prefix management
	prefix1<-unlist(strsplit(xmlName(xmlRoot(xmlObj)[[2]], full=T),':'))[1]
	prefix2<-unlist(strsplit(xmlName(xmlChildren(getNodeSet(xmlObj,paste('//',prefix1,':DataSet', sep=''))[[1]])[[1]], full = T),':'))[1]
	
	#concepts (attributes)
	conceptsXML<-getNodeSet(xmlObj, paste("//",prefix2,":SeriesKey/",prefix2,":Value", sep=""))
	concepts<-unique(sapply(conceptsXML, function(x) xmlGetAttr(x, "concept")))
	
	#series
	seriesXML<-getNodeSet(xmlObj, paste('//',prefix2,':Series', sep=''))
	seriesNb<-length(seriesXML)
	

	#converting SDMX series to a DataFrame R object
	for(x in 1:seriesNb){
		
		# Single serie XMLInternalNode converted into a XMLInternalDocument
		serieXML<-xmlDoc(seriesXML[[x]])
		
		#obsTimes
		obsTimesXML<-getNodeSet(serieXML, paste("//",prefix2,":Series/",prefix2,":Obs/",prefix2,":Time", sep=""))
		obsTime<-sapply(obsTimesXML,function(x) {xmlValue(x)})
		L<-length(obsTime)

		
		#Concept values (Note: the SeriesKey (concept attributes/values) are duplicated according to the number of Time observations)
		conceptValues<-as.data.frame(sapply(concepts, function(x){
														conceptValuesXML<-getNodeSet(serieXML, sprintf(paste("//",prefix2,":SeriesKey/",prefix2,":Value[@concept='%s']",sep=""),x))
														conceptValues<-lapply(conceptValuesXML,function(i) {rep(xmlGetAttr(i,"value"),L)})
														}))

		
		#single Serie as DataFrame
		serieDF<-cbind(conceptValues, obsTime)
		
		#add single DataFrame to dataset 
		if(x==1){ dataset<-serieDF }else{ dataset<-rbind(dataset,serieDF)}
	}
	
	# adding obsValues
	obsValuesXML<-getNodeSet(xmlObj,paste("//",prefix2,":ObsValue[@value]",sep=""))
	obsValue<-sapply(obsValuesXML, function(x) {xmlGetAttr(x,"value")})
	dataset<-cbind(dataset, obsValue)
	
	# workaround to ensure that numeric variables would not be considered as factors (having a obsValue variable as factor prevent from performing operations)
	checkMode<-function(x){
		options(warn=-1)
		check<-as.numeric(as.character(x))
		options(warn=0)
		if(is.na(check)) {
			return("factor")
		} else {
			return("numeric")
		}
	}
	modes<-sapply(dataset[1,], checkMode)
	for(i in 1:ncol(dataset)) dataset[,i]<-if(modes[i]=="numeric") as.numeric(as.character(dataset[,i])) else dataset[,i]
	
	# output
	return(dataset)
}

setAs("SDMXDataSet", "data.frame", function(from) as.data.frame.SDMXDataSet(from));
