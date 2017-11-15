<cfprocessingdirective suppresswhitespace="yes">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- DISPLAY ERROR/STATUS MESSAGE --->
<cfif isDefined('url.msg') or isDefined('session.msg') or isDefined('form.msg')>
	
    <cfif isDefined('url.msg')>
    	<cfset session.msg = #url.msg#>
    <cfelseif isDefined('form.msg')>
    	<cfset session.msg = #form.msg#>
    </cfif>
    
    <cfinvoke 
		component="#request.cfc#._messages"
		method="message" 
		value = "#session.msg#"
        returnvariable="result">
	</cfinvoke>
    
    <cfset show_message = #result#>

</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- URL MANAGEMENT --->
    <cfif isDefined('url.alias')> 
    	
        <!--- log user out --->
        <cfif #url.alias# eq "Logout">
        	<cfset structDelete(Session,"Auth")>
            
			<cfset session.msg = "logged_out">
            <cflocation url="Login" addtoken="no">
        </cfif>
        
		<!--- get content from Page to display --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_alias = '#url.alias#'
            returnvariable="data_Page">
        </cfinvoke>   

    </cfif>
    
    <!--- 404 if we can't find the requested page --->
    <cfif #data_Page.recordcount# eq 0 and #url.alias# neq "home">
    	<cflocation url="404.cfm" addtoken="no">
    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- LOGIN MANAGEMENT --->

	<cfif #url.alias# eq "Login">
       
        <!--- Log in admin --->
		<cfif isDefined('form.msg') and #form.msg# eq "login">
        
			<cfif #form.a_email# neq "" and #form.a_pswd# neq "">
        		
				<cfset form.redirect_success = "Home">
                <cfset form.redirect_failure = "Login">
                
                <cfinvoke
            		component="#request.cfc#.admin"
            		method="login" 
            		argumentcollection="#form#"
            		returnvariable="result">
        		</cfinvoke>
                
    		</cfif>
        
        </cfif>

		<!--- Recover Password --->
        <cfif isDefined('form.recover_password')>

			<cfset form.redirect_success = "Login">
            <cfset form.redirect_failure = "Login">
                        
            <cfinvoke 
                component="#request.cfc#.admin"
                method="recover_password" 
                argumentcollection="#form#"
                returnvariable="result">
            </cfinvoke>
            
        </cfif>

		<!--- Register --->
         <cfif isDefined('form.register')>
             
             <!--- Does email already exist --->
             <cfinvoke 
                component="#request.cfc#.admin"
                method="read" 
                a_email="#form.a_email#"
                returnvariable="result">
            </cfinvoke>             
            
            <cfif #result.recordcount# GT 0>
				<cfset session.msg = "email_already_registered">
            	<cflocation url="Login" addtoken="no">           
            </cfif>
            
			<!--- submit new registration  --->
             <cfinvoke 
                component="#request.cfc#.admin"
                method="create" 
                argumentcollection="#form#"
                returnvariable="result">
            </cfinvoke> 
            
            <!--- email temp password --->
            <cfinvoke 
                component="#request.cfc#.admin"
                method="read" 
                a_email="#form.a_email#"
                returnvariable="records_Admin">
            </cfinvoke>
                        
            <cfmail 
            	to="#records_Admin.a_email#" 
                from="noReply@NeaseCrossCountry.com"
                subject="NeaseCrossCountry.com Password"
                type="html">
                
                Hey #records_Admin.a_name_first#,<br />
                Your password is #records_Admin.a_pswd#<br />
                Please login to verify your account and start receiving notifications.<br />

            </cfmail>
            
			<cfset session.msg = "register_success">
            <cflocation url="Login" addtoken="no">
                  
		</cfif>

	</cfif>


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- MY PROFILE --->
	
	<cfif #url.alias# eq "My-Profile">
		
		<cfif isDefined('SESSION.Auth.is_logged_in') and #SESSION.Auth.is_logged_in# eq "Yes">

		
		<cfelse>
		
			<cflocation url="Logout" addtoken="No">
			<cfabort>
		
		</cfif>
		
	</cfif>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- MANAGE MY PROPERTIES --->
	
	<cfif #url.alias# eq "Manage-My-Properties">
		
		<cfif isDefined('SESSION.Auth.is_logged_in') and #SESSION.Auth.is_logged_in# eq "Yes">
			
			<!--- VIEW ALL PROPERTY FOR LOGGED IN USER --->
			<!-------------------------------------------->
			<cfinvoke 
				component="#request.cfc#.rentals"
				method="read" 
				admin_fk = '#SESSION.Auth.id#'
				returnvariable="records_Rentals" >
			</cfinvoke>
				
			<cfif isDefined('FORM.property_submit')>
				
				<!--- set the admin id based on the logged in user --->
				<!--- to pass to the insert query -------------------->
				<cfset FORM.admin_fk = #SESSION.Auth.id#>
				
				<cfinvoke 
					component="#request.cfc#.rentals"
					method="create" 
					argumentcollection="#FORM#">
				</cfinvoke>	
				
			<cfelseif isDefined('FORM.property_edit') or isDefined('FORM.view_delete')>
				
				<cfinvoke 
					component="#request.cfc#.rentals"
					method="read" 
					rental_id = '#FORM.rental_id#'
					returnvariable="records_Rentals" >
				</cfinvoke>

				<cfinvoke 
					component="#request.cfc#.rental_images"
					method="read" 
					rental_fk = '#FORM.rental_id#'
					returnvariable="records_Rental_Images" >
				</cfinvoke>

			<cfelseif isDefined('FORM.property_delete')>
				
				<cfinvoke 
					component="#request.cfc#.rentals"
					method="read" 
					rental_id = '#FORM.rental_id#'
					returnvariable="records_Rentals" >
				</cfinvoke>

				<cfinvoke 
					component="#request.cfc#.rental_images"
					method="read" 
					rental_fk = '#FORM.rental_id#'
					returnvariable="records_Rental_Images" >
				</cfinvoke>
							
			<cfelseif isDefined('FORM.property_update')>
 
				<!--- UPDATE PROPERTY--->
				<cfinvoke 
					component="#request.cfc#.rentals"
					method="update" 
					rental_id = '#FORM.rental_id#'
					argumentcollection="#FORM#" 
					returnvariable="result" >
				</cfinvoke>	
				
				<!--- GET MESSAGE FOR USER --->
				<cfinvoke 
					component="#request.cfc#._messages"
					method="message" 
					value="#result.status#"
					returnvariable="result">
				</cfinvoke>
				
				<cfset show_message = #result#>
				
				<!--- VIEW ALL PROPERTY FOR LOGGED IN USER --->
				<!-------------------------------------------->
				<cfinvoke 
					component="#request.cfc#.rentals"
					method="read" 
					admin_fk = '#SESSION.Auth.id#'
					returnvariable="records_Rentals" >
				</cfinvoke>

			<cfelse>
				
			</cfif>
			
		<cfelse>
		
			<cflocation url="Logout" addtoken="No">
			<cfabort>
		
		</cfif>
		
	</cfif>


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- SEARCH RESULTS --->
	
	<cfif #url.alias# eq "search-results" or #url.alias# eq "map-properties">  

			<cfinvoke
				component="#request.cfc#.rentals"
				method="read" 
				
				returnvariable="records_Rentals">
			</cfinvoke>
					
		<cfif isDefined('search_results')>
		
			<cfinvoke
				component="#request.cfc#.rentals"
				method="read" 
				argumentcollection="#FORM#"
				returnvariable="records_Rentals">
			</cfinvoke>
			
			<!--- save all form vars to session vars by field name --->
			<cfoutput>
				<cfloop collection="#form#" item="theField">
				<cfif theField is not "fieldNames">
					<cfset Session["#theField#"] = #form[theField]# />
				</cfif>
				</cfloop>
			</cfoutput>
		</cfif>
		
		<cfif isDefined('search_clear')>
			<!--- CLEAR ALL SESSION VARS FOR THE SEARCH --->
			<cfoutput>
				<cfloop collection="#form#" item="theField">
				<cfif theField is not "fieldNames">
					<cfset Session["#theField#"] = '' />
				</cfif>
				</cfloop>
			</cfoutput>
			
			<!--- GET x RECORDS AFTER THE SEARCH IS CLEARED --->
			<cfinvoke
				component="#request.cfc#.rentals"
				method="read"
				order_random="yes"
				returnvariable="records_Rentals">
			</cfinvoke>
			<cfset order_random = "yes">
			
		</cfif>
		
		<cfif isDefined('url.clear')>
			
			<cfset Session["#url.clear#"] = '' />
			
			<cfinvoke
				component="#request.cfc#.rentals"
				method="read" 
				argumentcollection="#SESSION#"
				returnvariable="records_Rentals">
			</cfinvoke>
			
		</cfif>
		
	</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- PROPERTY DETAILS --->
	
	<cfif #url.alias# eq "property-details">
	
	    <cfinvoke 
            component="#request.cfc#.rentals"
            method="read"
            rental_id="#FORM.rental_id#"
            returnvariable="records_Property_Details">
        </cfinvoke>
 
       	<cfinvoke 
            component="#request.cfc#.admin"
            method="read"
            admin_id="#records_Property_Details.admin_fk#"
            returnvariable="records_Admin">
        </cfinvoke>        	
        
	</cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- GALLERY MANAGEMENT --->
	
	<cfif #url.alias# eq "galleryX">        
        <cfinvoke 
            component="#request.cfc#.gallery"
            method="read"
            returnvariable="records_Gallery">
        </cfinvoke>	        
	</cfif>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- ADS MANAGEMENT --->
      
      <cfinvoke 
          component="#request.cfc#.ads"
          method="read"
          returnvariable="records_Ads">
      </cfinvoke>	        

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- LATEST NEWS MANAGEMENT --->

	<cfif isDefined('form.details_latest_news')>     
        
        <!--- get list of Latest News (pages.cfc) --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_alias = "#form.details_latest_news#"
            returnvariable="records_Latest_News">
        </cfinvoke>	        
    
	<cfelseif isDefined('form.view_archived_latest_news')>

		<!--- get All Latest News details (pages.cfc) --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = "-1"
            max_latest_news = "1"
            returnvariable="records_Latest_News">
        </cfinvoke>	
            
    <cfelse>
        
		<!--- get Latest News details (pages.cfc) max_latest_news set in Application.cfm file as default --->
        <cfinvoke 
            component="#request.cfc#.pages"
            method="read"
            p_parent_id = "-1"
            returnvariable="records_Latest_News">
        </cfinvoke>		
 
    </cfif>
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- CONTACT US MANAGEMENT --->

	<cfif #url.alias# eq "contact-us">
		<!--- set default contact_us session vars --->
        <cfparam name="session.contact_us.name" default="">
        <cfparam name="session.contact_us.email" default="">
        <cfparam name="session.contact_us.hear_about_us" default="">
        <cfparam name="session.contact_us.comment" default="">
    </cfif>
    
	<!--- SEND CONTACT EMAIL --->
    <cfif isDefined('form.send_contact_us')>
    	
        <cfif #form.match_this# eq #session.random_captcha#>
        	
            <cfinvoke 
                component="#request.cfc#._messages"
                method="message" 
                value="contact_email_sent"
                returnvariable="result">
            </cfinvoke>

            <cfset session.show_message = #result#>
        
            <!--- SEND CONTACT EMAIL --->

			<!--- to user 
            <cfmail to="#form.email#"
                from="#request.default_from_email#"
                subject="Thank you for Contacting #request.title#"
                type="text">
                #form.name#
            
                We have received your email and will reply as soon as possible.
            
                Thank You
            </cfmail>--->
            
            <!--- to default email
            <cfmail to="#request.default_to_email#"
                from="#request.default_from_email#"
                subject="Contact Form from #request.title#"
                type="text">
                #form.name#
            
                #form.email#
            
                #form.hear_about_us#
                
                #form.comment#
            </cfmail> --->
            
            <!--- email was sent - clear contact-us session vars --->
            <cfset session.contact_us.name = "">
            <cfset session.contact_us.email = "">
            <cfset session.contact_us.hear_about_us = "">
            <cfset session.contact_us.comment = "">
        
        <cfelse>
        	
            <!--- error in sending email - save contact-us vars to session vars to populate the form with info input by user --->
			<cfset session.contact_us.name = #form.name#>
            <cfset session.contact_us.email = #form.email#>
            <cfset session.contact_us.hear_about_us = #form.hear_about_us#>
            <cfset session.contact_us.comment = #form.comment#>
            
            <cfinvoke 
                component="#request.cfc#._messages"
                method="message" 
                value="contact_email_not_sent"
                returnvariable="result">
            </cfinvoke>
            
            <cfset session.show_message = #result#>
            
            <!--- LOG IP ADDRESS --->
            
        </cfif>
        
    </cfif>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- BIOS MANAGEMENT --->
    
    <cfif isDefined('form.bio_id')>        
        <cfinvoke 
            component="#request.cfc#.bios"
            method="read"
            bio_id = "#form.bio_id#"
            returnvariable="records_Bios">
        </cfinvoke>	        
    <cfelse>
        <cfinvoke 
            component="#request.cfc#.bios"
            method="read"
            returnvariable="records_Bios">
        </cfinvoke>
    </cfif>			
		
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- MESSAGE BOARD MANAGEMENT --->

	<cfif #url.alias# eq "message-board">
		<!--- set default contact_us session vars --->
        <cfparam name="session.message_board.mb_name_first" default="">
        <cfparam name="session.message_board.mb_name_last" default="">
        <cfparam name="session.message_board.mb_message" default="">
    </cfif>

    <cfif isDefined('form.send_message_board')>
    	
        <cfif #form.match_this# eq #session.random_captcha#>
 		
            <cfinvoke 
                component="#request.cfc#._security"
                method="strip_all_tags_Security" 
                str = "#form.mb_message#"
                returnvariable="clean_string">
            </cfinvoke>
            
            <cfset form.mb_comment = #clean_string# >
            
            <cfinvoke 
                component="#request.cfc#.message_board"
                method="create"
                argumentcollection="#form#"
        		returnvariable="result">
            </cfinvoke>
            
            <cfset session.show_message = #result#>            
            
		<cfelse>
        	
            <!--- error in sending email - save contact-us vars to session vars to populate the form with info input by user --->
			<cfset session.message_board.mb_name_first = #form.mb_name_first#>
            <cfset session.message_board.mb_name_last = #form.mb_name_last#>
            <cfset session.message_board.mb_message = #form.mb_message#>
            
            <cfinvoke 
                component="#request.cfc#._messages"
                method="message" 
                value="captcha_not_matched"
                returnvariable="result">
            </cfinvoke>
            
            <cfset session.show_message = #result#> 
		
        </cfif>      
    
    </cfif>
    
    <!--- display to the user --->            
    <cfif isDefined('form.message_board_id')>        
        <cfinvoke 
            component = "#request.cfc#.message_board"
            method = "read"
            bio_id = "#form.message_board_id#"
            returnvariable = "records_Message_Board">
        </cfinvoke>	        
    <cfelse>
        <cfinvoke 
            component = "#request.cfc#.message_board"
            method = "read"
            mb_approved = "1"
            returnvariable = "records_Message_Board">
        </cfinvoke>
        
    </cfif>			

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- CONTROL PANEL --->

	<cfif #url.alias# eq "Control-Panel">
		

    
    </cfif>


<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
<!--- INDEX MANAGEMENT --->
	
	<!--- hard coded for the index page sections --->
    <cfinvoke 
        component="#request.cfc#.pages"
        method="read"
        p_alias = 'footer'
        returnvariable="footer">
    </cfinvoke>
    
    <cfinvoke 
        component="#request.cfc#.pages"
        method="read"
        p_parent_id = '1'
        returnvariable="sub_About_Us">
    </cfinvoke> 

    <cfinvoke 
        component="#request.cfc#.providers"
        method="read"
        returnvariable="records_Providers">
    </cfinvoke>  

	<cfif #url.alias# eq "home">
		<cfinvoke
			component="#request.cfc#.rentals"
			method="read"
			order_random="yes"
			returnvariable="records_Rentals">
		</cfinvoke>
		<cfset order_random = "yes">
	</cfif>                              
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
    
</cfprocessingdirective>