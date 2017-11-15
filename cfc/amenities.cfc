<cfcomponent displayname="Amenities Table Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="amenity_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT amenity_id, am_name
			  FROM amenities
             WHERE 0=0
			 <cfif #arguments.amenity_id# neq "">
               AND amenity_id = <cfqueryparam value = "#arguments.amenity_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
          ORDER BY am_name         
		</cfquery>
        
		<cfreturn query>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">
        
	</cffunction>
   
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cffunction name="html_checkbox_amenities" returntype="string">

		<cfargument name="rental_fk" type="string" required="false" default="0">
		
		<cfset checked = ''>
		
		<cfinvoke 
            component="#request.cfc#.amenities"
            method="read"
            returnvariable="records_Amenities">
       	</cfinvoke>
       	
		<div class="property-amenities">
    		<ul>
				<cfoutput query="records_Amenities">
  						
  						<cfif #arguments.rental_fk# neq 0>
							<cfinvoke 
								component="#request.cfc#.rental_x_amenities"
								method="read"
								rental_fk="#arguments.rental_fk#"
								amenity_fk="#records_Amenities.amenity_id#"
								returnvariable="records_Rental_x_Amenities">
							</cfinvoke>

							<cfif #records_Rental_x_Amenities.RecordCount# eq 1>
								<cfloop query="records_Rental_x_Amenities">
									<cfset checked = 'checked=checked'>
								</cfloop>
							</cfif>
						</cfif>
  					
   					<li><label><input name="amenity_fk[]" type="checkbox" value="#records_Amenities.amenity_id#" #checked#> #records_Amenities.am_name# </label></li>
   					<cfset checked = ''>
				</cfoutput>
    		</ul>
		</div>

	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

	<cffunction name="html_property_details_checked_amenities" returntype="string">

		<cfargument name="rental_fk" type="string" required="false" default="0">
		
		<cfset class = 'no'>
		
		<cfinvoke 
            component="#request.cfc#.amenities"
            method="read"
            returnvariable="records_Amenities">
       	</cfinvoke>
       	
       	<div class="property-amenities">
			<ul>
				<cfoutput query="records_Amenities">
  						
  						<cfif #arguments.rental_fk# neq 0>
							<cfinvoke 
								component="#request.cfc#.rental_x_amenities"
								method="read"
								rental_fk="#arguments.rental_fk#"
								amenity_fk="#records_Amenities.amenity_id#"
								returnvariable="records_Rental_x_Amenities">
							</cfinvoke>

							<cfif #records_Rental_x_Amenities.RecordCount# eq 1>
								<cfloop query="records_Rental_x_Amenities">
									<cfset class="yes">
								</cfloop>
							</cfif>
						</cfif>
  					
   					<li class="#class#">#records_Amenities.am_name#</li>
   					<cfset class = 'no'>
				</cfoutput>
			</ul>
		</div><!--- /.property-amenities --->
       	
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
