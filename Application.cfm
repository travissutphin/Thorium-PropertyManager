<cfprocessingdirective suppresswhitespace="yes">
<cfset request.cfc = "thorium.cfc">	
<cfset request.DSN = "thorium_beta">    
<cfset request.masterDSN = "">

<cfset request.title = "beta">
<cfset request.siteURL = "http://#cgi.server_name#/thorium/">
<cfset request.appURL = "http://#cgi.server_name#/thorium/cms/">
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
	NAME="#request.title#-Thorium90" 
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