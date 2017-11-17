<cfprocessingdirective suppresswhitespace="yes">

<cfif #cgi.server_name# eq "homesforrentinstaugustine.com">

	<cfset request.cfc = "cfc">	
	<cfset request.DSN = "thorium_property_manager">    
	<cfset request.title = "Homes for Rent in St Augustine">
	<cfset request.directory = "">

<cfelse>

	<cfset request.cfc = "thorium-propertymanager.cfc">	
	<cfset request.DSN = "thorium_property_manager">    
	<cfset request.title = "Thorium Property Manager">
	<cfset request.directory = "thorium_propertymanager/">
	
</cfif>

<cfset request.masterDSN = "">
<cfset request.siteURL = "http://#cgi.server_name#/#request.directory#">
<cfset request.appURL = "http://#cgi.server_name#/#request.directory#cms/">
<cfset request.upLoadRoot = "#Expandpath(".\")#">
<cfset this_page = GetFileFromPath (GetTemplatePath ())>
<cfset this_domain = "http://#cgi.server_name##Replace (cgi.path_info, '/#this_page#', '', 'ALL')#">
<cfset request.debug = "On"><!--- On or Off - this ads cfthrow to the cfcatch --->

<!--- DEFAULT VARIABLES --->
<!------------------------->
<cfset request.default_to_email = "test@email.com">
<cfset request.default_from_email = "noReply@email.com">

<!--- FOR MESSAGE BOARD TEMPLATE --->
<cfset request.message_board_image = "On">

<!--- IMAGE SETTINGS --->
<!---------------------->
<cfset request.image_manipulator = "cfimage"><!--- cfimage or jpegresize --->
<!--- message boards --->
<cfset request.width_rental = "1920">
<cfset request.height_rental = "1080">
    
<!------------------------->
<!--- DEFAULT VARIABLES --->


<!--- APPLICATION MGNT --->
<!------------------------>
<CFAPPLICATION
	NAME="#request.title#-Thorium#DateFormat(Now())#" 
	SESSIONMANAGEMENT="Yes"
	SESSIONTIMEOUT="#CreateTimeSpan(0, 1, 0, 0)#">
<!------------------------>
<!--- APPLICATION MGNT --->   


<!--- ERROR HANDLING --->
<!-------------------
    <cferror type="validation" template="error_report.cfm" >
    <cferror type="exception" template="error_report.cfm" >
    <cferror type="request" template="error_report.cfm" >--->
<!---------------------->
<!--- ERROR HANDLING --->


</cfprocessingdirective>