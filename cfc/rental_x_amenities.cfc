<cfcomponent displayname="Rental x Amenities Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create">

        <cfargument name="rental_fk" type="numeric" required="false" default="">
        <cfargument name="amenity_fk" type="numeric" required="false" default="">

			<cftry>
				<cflock name="add_to_table" type="exclusive" timeout="5">
	            	
					<cfquery name="insert" datasource="#request.DSN#" result="insert_Result" >
						INSERT INTO rental_x_amenities
						(amenity_fk, rental_fk)
						VALUES
						(
							<cfqueryparam value = "#arguments.amenity_fk#" cfsqltype = "cf_sql_numeric">,
							<cfqueryparam value = "#arguments.rental_fk#" cfsqltype = "cf_sql_numeric">
						)
					</cfquery>	

				</cflock>	
					<cfcatch type="any">
					
						<cfset result.status = "error_creating">
    
                        <cfif #request.debug# eq "On">
                            <cfrethrow />
                        </cfif>
                    	
					</cfcatch>
			</cftry>
		 
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">

        <cfargument name="rental_fk" type="numeric" required="false" default="0">
        <cfargument name="amenity_fk" type="numeric" required="false" default="0">
		
        <cftry>
			<cflock name="read" type="readonly" timeout="5">        
               
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT rxa.rental_fk, rxa.amenity_fk, am.am_name
                      FROM rental_x_amenities rxa
                      JOIN rentals re ON re.rental_id = rxa.rental_fk
                      JOIN amenities am ON am.amenity_id = rxa.amenity_fk
                     WHERE 0=0
                     
                     <cfif #arguments.rental_fk# neq "0">
                       AND rxa.rental_fk = <cfqueryparam value = "#arguments.rental_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
        
                     <cfif #arguments.amenity_fk# neq "0">
                       AND rxa.amenity_fk = <cfqueryparam value = "#arguments.amenity_fk#" cfsqltype = "cf_sql_numeric"> 
                     </cfif>
                                    
                </cfquery>

			</cflock>	
				
                <cfcatch type="any">
					
					<cfset result.status = "error_reading">
                    
                    <cfif #request.debug# eq "On">
                        <cfrethrow />
                    </cfif>
                    	
				</cfcatch>
                
		</cftry>
                
        <cfreturn query>
        		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update" returntype="struct">
			    
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete">

		<cfargument name="rental_fk" type="numeric" required="false" default="">

		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="delete" datasource="#request.DSN#" >
                    DELETE FROM rental_x_amenities
                     WHERE rental_fk = <cfqueryparam value = "#arguments.rental_fk#" cfsqltype = "cf_sql_numeric"> 
				</cfquery> 	
                
			</cflock>	
				<cfcatch type="any">
					
					<cfset result.status = "error_deleting">

                   	<cfif #request.debug# eq "On">
                        <cfrethrow />
                    </cfif>
                    	
				</cfcatch>
		</cftry>
		
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->			

	<cffunction name="html_list_pages_x_links" returntype="any">
    	
	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
