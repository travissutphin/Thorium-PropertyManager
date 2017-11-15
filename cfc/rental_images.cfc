<cfcomponent displayname="Rental_Images Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="rental_image_id" type="string" required="no" default="">       
        <cfargument name="ri_order" type="string" required="no" default="">
        <cfargument name="image" type="string" required="no" default="">
		<cfargument name="save_image" type="string" required="no" default="">
        <cfargument name="rental_fk" type="string" required="no" default="">
                   
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">
                    
		<cfimage
			action = "info"
			source = "#request.upLoadRoot#assets\images\temp\#arguments.image#"
			structname = "image_size_info">

		<cfif #image_size_info.height# gt #image_size_info.width#>
			<cfimage
				action = "resize"
				height = "#request.height_rental#"
				width = ""
				source = "#Request.upLoadRoot#assets\images\temp\#arguments.image#"
				destination = "#Request.upLoadRoot#assets\images\uploads\#arguments.save_image#"
				quality='1'>                 
		<cfelseif #image_size_info.height# eq #image_size_info.width#>
			<cfimage
				action = "resize"
				width = "#request.width_rental#"
				height = "#request.width_rental#"
				source = "#Request.upLoadRoot#assets\images\temp\#arguments.image#"
				destination = "#Request.upLoadRoot#assets\images\uploads\#arguments.save_image#"
				quality='1'> 
		<cfelse>     
			<cfimage
				action = "resize"
				width = "#request.width_rental#"
				height = ""
				source = "#Request.upLoadRoot#assets\images\temp\#arguments.image#"
				destination = "#Request.upLoadRoot#assets\images\uploads\#arguments.save_image#"
				quality='1'> 
		</cfif>

		<cfif FileExists("#Request.upLoadRoot#assets\images\temp\#arguments.image#")>
			<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#arguments.image#">
		</cfif>
                                  
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_Result" >
                    INSERT INTO rental_images
                    (ri_order, ri_image, rental_fk)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.ri_order#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.rental_fk#" cfsqltype = "cf_sql_varchar">       
                     );
				</cfquery> 	
                
			</cflock>	
				<cfcatch type="any">
				
					<cfset result.status = "error_creating">
    
                    <cfif #request.debug# eq "On">
                        <cfrethrow />	
                    </cfif>
                
				</cfcatch>
		</cftry>
								
		<cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="rental_image_id" type="string" required="no" default="">       
        <cfargument name="ri_order" type="string" required="no" default="">
        <cfargument name="ri_image" type="string" required="no" default="">
        <cfargument name="rental_fk" type="string" required="no" default="">


		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT rental_image_id, ri_image, ri_order, rental_fk
                      FROM rental_images
                     WHERE 0=0
                     <cfif #arguments.rental_fk# neq "">
                       AND rental_fk = <cfqueryparam value = "#arguments.rental_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 
                  ORDER BY ri_order             
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
		
        <cfargument name="ren_address" type="string" required="no" default="">
        <cfargument name="ren_city" type="string" required="no" default="">
        <cfargument name="ren_state" type="string" required="no" default="">
        <cfargument name="ren_zip" type="string" required="no" default="">
        <cfargument name="ren_description" type="string" required="no" default="">
        <cfargument name="community_fk" type="string" required="no" default="">
        <cfargument name="ren_cost" type="string" required="no" default="">
        <cfargument name="bed_fk" type="string" required="no" default="">
        <cfargument name="bath_fk" type="string" required="no" default="">
        <cfargument name="garage_fk" type="string" required="no" default="">
        <cfargument name="school_grade_fk" type="string" required="no" default="">
        <cfargument name="school_middle_fk" type="string" required="no" default="">
        <cfargument name="school_high_fk" type="string" required="no" default="">
        <cfargument name="home_type_fk" type="string" required="no" default="">
        <cfargument name="sq_ft_fk" type="string" required="no" default="">
        <cfargument name="updated_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        
        <cfargument name="ri_image" type="string" required="no" default="">
               
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "property_updated">
 
        <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
 
		<cfloop index="i" list="#FORM.myimage#" delimiters=",">
		
			<!--- upload the image --->
            <cffile action="upload" filefield="myimage" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            <cfset thumb_image = "th_#string_is##cffile.serverFile#">

            <!--- resize image --->
            <cfif #request.image_manipulator# eq "cfimage">
                    
                <cfimage
                    action = "info"
                    source = "#request.upLoadRoot#assets\images\temp\#image#"
                    structname = "image_size_info">
           
                <cfif #image_size_info.height# gt #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        height = "#request.height_rental#"
                        width = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                        quality='1'>                 
                <cfelseif #image_size_info.height# eq #image_size_info.width#>
                    <cfimage
                        action = "resize"
                        width = "#request.width_rental#"
                        height = "#request.width_rental#"
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                        quality='1'> 
 
                <cfelse>     
                    <cfimage
                        action = "resize"
                        width = "#request.width_rental#"
                        height = ""
                        source = "#Request.upLoadRoot#assets\images\temp\#image#"
                        destination = "#Request.upLoadRoot#assets\images\uploads\#save_image#"
                        quality='1'> 

            	</cfif>
 
                <cfif FileExists("#Request.upLoadRoot#assets\images\temp\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\temp\#image#">
            	</cfif>
            	
              
						<cfquery name="query" datasource="#request.DSN#">
							INSERT INTO rental_images
							(ri_image, rental_fk)
							VALUES
							(<cfqueryparam value = "#save_image#" cfsqltype = "cf_sql_varchar">,
							<cfqueryparam value="#arguments.rental_id#" cfsqltype="cf_sql_integer">
							);
						</cfquery>

            </cfif><!--- // <cfif #request.image_manipulator# eq "cfimage"> --->
            <!--- // resize image --->      				   
        
        </cfloop>    
          						
        <cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery name="query" datasource="#request.DSN#">
                    UPDATE rentals
                       SET ren_address = <cfqueryparam value = "#arguments.ren_address#" cfsqltype = "cf_sql_varchar">,
                           ren_city = <cfqueryparam value = "#arguments.ren_city#" cfsqltype = "cf_sql_varchar">,
                           ren_state = <cfqueryparam value = "#arguments.ren_state#" cfsqltype = "cf_sql_varchar">,
                           ren_zip = <cfqueryparam value = "#arguments.ren_zip#" cfsqltype = "cf_sql_varchar">,
                           ren_description = <cfqueryparam value = "#arguments.ren_description#" cfsqltype = "cf_sql_varchar">,
                           community_fk = <cfqueryparam value = "#arguments.community_fk#" cfsqltype = "cf_sql_varchar">,
                           ren_cost = <cfqueryparam value = "#arguments.ren_cost#" cfsqltype = "cf_sql_varchar">,
                           bed_fk = <cfqueryparam value = "#arguments.bed_fk#" cfsqltype = "cf_sql_integer">,
                           bath_fk = <cfqueryparam value = "#arguments.bath_fk#" cfsqltype = "cf_sql_integer">,
                           garage_fk = <cfqueryparam value = "#arguments.garage_fk#" cfsqltype = "cf_sql_integer">,		
                           school_grade_fk = <cfqueryparam value = "#arguments.school_grade_fk#" cfsqltype = "cf_sql_integer">,
                           school_middle_fk = <cfqueryparam value = "#arguments.school_middle_fk#" cfsqltype = "cf_sql_integer">,
                           school_high_fk = <cfqueryparam value = "#arguments.school_high_fk#" cfsqltype = "cf_sql_integer">,
                           home_type_fk = <cfqueryparam value = "#arguments.home_type_fk#" cfsqltype = "cf_sql_integer">,
                           sq_ft_fk = <cfqueryparam value = "#arguments.sq_ft_fk#" cfsqltype = "cf_sql_varchar">,
                           updated_at = <cfqueryparam value = "#arguments.updated_at#" cfsqltype = "cf_sql_varchar">
                     WHERE rental_id = <cfqueryparam value="#arguments.rental_id#" cfsqltype="cf_sql_integer">;
                </cfquery>

            </cflock>

            <cfcatch type="any">
            	
				<cfset result.status = "error_updating">
				
                <cfif #request.debug# eq "On">
                	<cfrethrow />	
                </cfif>
    
            </cfcatch>
        </cftry>
		
		<!--- AMENITIES --->
		<!----------------->
       	
       	<!-- INSERT AMENITIES START --->
       	<!----------------------------->
		<cfset outputLen = #ListLen(FORM['AMENITY_FK[]'],",")# >

		<cfif #outputLen# gt 0>

			<!-- DELETE EXISTING AMENITIES --->
       		<!-------------------------------------->
       		<cfinvoke
       			component="#request.cfc#.rental_x_amenities"
       			method="delete"
       			rental_fk="#arguments.rental_id#">
       		</cfinvoke>
       		
			<cfloop index="i" list="#FORM['AMENITY_FK[]']#">    
			
				<cfinvoke 
					component="#request.cfc#.rental_x_amenities"
					method="create" 
					rental_fk="#arguments.rental_id#"
					amenity_fk="#i#">
				</cfinvoke>
				
			</cfloop>
			
		</cfif>
		<!-- INSERT AMENITIES END --->
		<!--------------------------->	
        								
		<cfreturn result>
        
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->		

	<cffunction name="update_ordering" returntype="struct">

        <cfargument name="rental_id" type="string" required="yes" >
        <cfargument name="ren_order" type="string" required="yes" >

		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "updated_ordering">

		<cftry>
            <cflock name="update_table" type="exclusive" timeout="5">
                
                <cfquery datasource="#request.DSN#">
                    UPDATE rental
                       SET ren_order = <cfqueryparam value = "#arguments.ren_order#" cfsqltype = "cf_sql_integer"> 			
                     WHERE rental_id = <cfqueryparam value="#arguments.rental_id#" cfsqltype="cf_sql_integer">;
                </cfquery>
                
            </cflock>

            <cfcatch type="any">
            	
				<cfset result.status = "error_updating">

                <cfif #request.debug# eq "On">
                	<cfrethrow />	
                </cfif>
                
            </cfcatch>
        </cftry>

		<cfreturn result>                    
    
    </cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	

	<cffunction name="delete" returntype="struct">
		
        <cfargument name="rental_fk" type="string" required="yes" >
       	<cfargument name="ri_order" type="string" required="yes" >
       	<cfargument name="image" type="string" required="yes" >			
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    DELETE FROM rental_images
                     WHERE rental_fk = <cfqueryparam value="#arguments.rental_fk#" cfsqltype="cf_sql_integer"> 
                       AND ri_order = <cfqueryparam value="#arguments.ri_order#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
                	
			</cflock>	
            <cfcatch type="any">

                <cfset result.status = "error_deleting">

                <cfif #request.debug# eq "On">
                    <cfrethrow />	
                </cfif>
            
            </cfcatch>
		</cftry>	
		
       <cfif FileExists("#Request.upLoadRoot#assets\images\uploads\#image#")>
                	<cffile action = "delete" file = "#Request.upLoadRoot#assets\images\uploads\#image#">
            	</cfif>
            	
        <cfreturn result>
        
	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

</cfcomponent>
