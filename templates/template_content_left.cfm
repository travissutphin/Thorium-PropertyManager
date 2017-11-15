<!--- CONTENT AREA STARTS HERE --->
<!--- CONTENT ON LEFT ----------->
<!-------------------------------->
<div class="main">
 
	<div class="container">
		
		<div class="row">
        
        
		<!--- LEFT COLUMN --->
      	<!-------------------->
        <div class="content col-sm-8 col-md-9">
			
			<div class="row">

			<!--- TEMPLATE BEFORE CONTENT --->
			<!------------------------------->
			<cfif #data_Page.p_template_before# neq '0'>

				<cfinvoke 
					component="#request.cfc#.page_templates"
					method="read"
					page_template_id = "#data_Page.p_template_before#"
					returnvariable="template_before_content">
				</cfinvoke>

				<cfoutput query="template_before_content">
					<cfinclude template="../templates/#template_before_content.pt_template#">
				</cfoutput>

			</cfif>

 			<!--- PAGE CONTENT ---> 
 			<!-------------------->
 			<div class="col-md-12"> 
			    
            <cfoutput>
				<cfif #data_page.p_image# neq "">
                <img src="#request.siteURL#assets/images/uploads/#data_page.p_image#" width="250px" hspace="25px" vspace="5px" class="img-responsive pull-left" />
                </cfif>
                <cfset image_location = #request.siteURL# & "assets/images/">
                <cfset p_content = replace(#data_Page.p_content#,"../assets/images/",#image_location#,"ALL")>
                #p_content#
            </cfoutput>
        
        	</div>

       	
        	<!--- SHOW TEMPLATE IF INCLUDED IN THE CONTROLLER --->
        	<!--------------------------------------------------->
       		<cfif isDefined('show_template')>
				<cfinclude template="../templates/#show_template#">
			</cfif>

						
			<!--- TEMPLATE AFTER CONTENT --->
			<!------------------------------>
			<cfif #data_Page.p_template_after# neq '0'>

				<cfinvoke 
					component="#request.cfc#.page_templates"
					method="read"
					page_template_id = "#data_Page.p_template_after#"
					returnvariable="template_after_content">
				</cfinvoke>

				<cfoutput query="template_after_content">
					<cfinclude template="../templates/#template_after_content.pt_template#">
				</cfoutput>

			</cfif>

			</div><!-- /.row -->

		</div><!-- /.content -->
		<!-------------------->
		
		
		<!--- LEFT COLUMN --->
		<!-------------------->
		<div class="sidebar col-sm-4 col-md-3">

			<div class="widget">
				<cfinclude template="template_nav_left_right.cfm">
			</div><!-- /.widget -->

		</div><!-- /.sidebar -->
		<!-------------------->
              
        </div><!-- /.row -->
        
	</div><!-- /.container -->

</div><!-- /.main -->

<!--- CONTENT AREA ENDS HERE --->
<!-------------------------------->