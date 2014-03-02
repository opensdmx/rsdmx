# rsdmx - RSDMXHeader class
#
# Author: Emmanuel Blondel
#==========================

#SDMXHeader class
setClass("SDMXHeader",
		representation(
			ID 	= "character", Test = "logical", Truncated = "logical", Name = "character",
			Sender = "list", Receiver = "list",
			Prepared = "POSIXlt", Extracted = "POSIXlt",
			ReportingBegin = "POSIXlt", ReportingEnd = "POSIXlt",
			#KeyFamilyRef = "character", # xs:NMTOKEN?
			#KeyFamilyAgency = "character", # xs:NMTOKEN?
			#DataSetAgency = "character", # xs:NMTOKEN?
			#DataSetID = "character",
			#DataSetAction = "character", #TODO see ActionType
			#
			
			Source = "character"
		),
		prototype = list(
			ID = "Id", Test = FALSE, Truncated = FALSE, Name = "name",
			Sender = list(id = "SenderID", en = "sender"), Receiver = list(id = "ReceiverID", en="receiver"),
			Prepared = Sys.time(), Extracted = Sys.time(),
			ReportingBegin = Sys.time(), ReportingEnd = Sys.time(),
			#KeyFamilyRef = "character", # xs:NMTOKEN
			#KeyFamilyAgency = "character", # xs:NMTOKEN
			#DataSetAgency = "character", # xs:NMTOKEN
			#DataSetID = "datasetID",
			#DataSetAction = "character", #TODO see ActionType
			#Extracted = "POSIXt", #dateTime
			
			Source = "source"
			),
		validity = function(object){
			
			# ID validation
			if(is.null(object@ID)) return(FALSE)
			if(attr(regexpr("[a-zA-Z0-9@-_@\\$]", object@ID),"match.length") == -1) return(FALSE)
			
			#Test/Truncated
			if(!is.logical(object@Test)) return(FALSE)
			if(!is.logical(object@Truncated)) return(FALSE)
			
			#Dates/Time validation
			if(is.na(object@Prepared)) return(FALSE)
			
			#Sender/Receiver validation
			if(is.na(object@Sender$id) || nchar(object@Sender$id) == 0) return(FALSE)
			if(nchar(object@Receiver$id) == 0) return(FALSE)
			
			#TODO KeyFamilyRef validation
			#TODO KeyFamilyAgency validation
			#TODO DataSetAgency validation
			
			#DatasetID validation
			#if(object@DatasetID != NULL && length(object@Receiver) == 0) return(FALSE);
			
			#TODO DataSetAction validation
			#TODO ReportingBegin validation
			#TODO ReportingEnd validation
			
			return(TRUE);
		}
)

#	<xs:sequence>
#	<xs:element name="ID" type="common:IDType"/>
#	<xs:element name="Test" type="xs:boolean" default="false"/>
#	<xs:element name="Truncated" type="xs:boolean" minOccurs="0"/>
#	<xs:element name="Name" type="common:TextType" minOccurs="0" maxOccurs="unbounded"/>
#	<xs:element name="Prepared" type="HeaderTimeType"/>
#	<xs:element name="Sender" type="PartyType" maxOccurs="unbounded">
#	<xs:unique name="SDMX_SenderNameLanguageUniqueness">
#	<xs:selector xpath="message:Name"/>
#	<xs:field xpath="@xml:lang"/>
#	</xs:unique>
#	</xs:element>
#	<xs:element name="Receiver" type="PartyType" minOccurs="0" maxOccurs="unbounded">
#	<xs:unique name="SDMX_ReceiverNameLanguageUniqueness">
#	<xs:selector xpath="message:Name"/>
#	<xs:field xpath="@xml:lang"/>
#	</xs:unique>
#	</xs:element>
#	<xs:element name="KeyFamilyRef" type="xs:NMTOKEN" minOccurs="0"/>
#	<xs:element name="KeyFamilyAgency" type="xs:NMTOKEN" minOccurs="0"/>
#	<xs:element name="DataSetAgency" type="xs:NMTOKEN" minOccurs="0"/>
#	<xs:element name="DataSetID" type="xs:NMTOKEN" minOccurs="0"/>
#	<xs:element name="DataSetAction" type="common:ActionType" minOccurs="0"/>			
#	<xs:element name="Extracted" type="xs:dateTime" minOccurs="0"/>
#	<xs:element name="ReportingBegin" type="HeaderTimeType" minOccurs="0"/>
#	<xs:element name="ReportingEnd" type="HeaderTimeType" minOccurs="0"/>
#	<xs:element name="Source" type="common:TextType" minOccurs="0" maxOccurs="unbounded"/>
#	</xs:sequence>
