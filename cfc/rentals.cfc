<cfcomponent displayname="Rentals Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">

        <cfargument name="admin_fk" type="string" required="no" default="">
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
        <cfargument name="created_at" type="string" required="no" default="#DateFormat(now(), 'yyyy-mm-dd')#">
        
        <cfargument name="ri_image1" type="string" required="no" default="">
        <cfargument name="ri_image2" type="string" required="no" default="">
        <cfargument name="ri_image3" type="string" required="no" default="">
        <cfargument name="ri_image4" type="string" required="no" default="">
        <cfargument name="ri_image5" type="string" required="no" default="">
                
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "created">        

        <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
        
        <!--- get lat and long of address entered --->
        <cfinvoke 
			component="#request.cfc#._maps"
			method="findLatLong"
			street="#arguments.ren_address#"
			city="#arguments.ren_city#"
			state="#arguments.ren_state#"
			zip="#arguments.ren_zip#"
			returnvariable="source">
		</cfinvoke> 
                                  
		<cftry>
			<cflock name="add_to_table" type="exclusive" timeout="5">
            	
				<cfquery name="insert" datasource="#request.DSN#" result="insert_Result" >
                    INSERT INTO rentals
                    (admin_fk, ren_address, ren_latitude, ren_longitude, ren_city, ren_state, ren_zip, 
                     ren_description, community_fk, ren_cost, bed_fk, bath_fk, garage_fk, school_grade_fk, school_middle_fk, school_high_fk, 
                     home_type_fk, sq_ft_fk, created_at)
                    VALUES
                    (
                        <cfqueryparam value = "#arguments.admin_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_address#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#source.latitude#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#source.longitude#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_city#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_state#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_zip#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_description#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.community_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.ren_cost#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bed_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.bath_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.garage_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.school_grade_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.school_middle_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.school_high_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.home_type_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.sq_ft_fk#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.created_at#" cfsqltype = "cf_sql_varchar">        
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
		
		
		<!--- GET THE PRIMARY KEY OF THE INSERTED RECORD --->
		<cfset NewPrimaryKey = insert_Result.generatedkey>
      	
      	
       	<!-- INSERT AMENITIES START --->
       	<!----------------------------->
		<cfset outputLen = #ListLen(FORM['AMENITY_FK[]'],",")# >

		<cfif #outputLen# gt 0>
			<cfloop index="i" list="#FORM['AMENITY_FK[]']#">    
				
				<cfinvoke 
					component="#request.cfc#.rental_x_amenities"
					method="create" 
					rental_fk="#NewPrimaryKey#"
					amenity_fk="#i#">
				</cfinvoke>	
				
			</cfloop>
		</cfif>
		<!-- INSERT AMENITIES END --->
		<!--------------------------->		

		<!-- INSERT IMAGE START --->
		<!------------------------->	
		<cfif #arguments.ri_image1# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image1" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='1'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#NewPrimaryKey#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

		<cfif #arguments.ri_image2# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image2" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='2'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#NewPrimaryKey#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

        <cfif #arguments.ri_image3# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image3" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='3'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#NewPrimaryKey#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->        
		<!-- INSERT IMAGE END --->
		<!----------------------->	

		<cfif #arguments.ri_image4# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image4" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='4'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#NewPrimaryKey#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

      	<cfif #arguments.ri_image5# neq "">
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image5" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='5'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#NewPrimaryKey#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->
                								
		<cfreturn result>
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="rental_id" type="string" required="no" default="">
        <cfargument name="admin_fk" type="string" required="no" default="">
        <cfargument name="ren_address" type="string" required="no" default="">
        <cfargument name="ren_latitude" type="string" required="no" default="">
        <cfargument name="ren_longitude" type="string" required="no" default="">
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
        
        <cfargument name="order_random" type="string" required="no" default="">


		<cftry>
			<cflock name="read" type="readonly" timeout="5">        
                
                <cfquery name="query" datasource="#request.DSN#">
                    
                    SELECT r.rental_id, r.admin_fk, r.ren_address, r.ren_latitude, r.ren_longitude, r.ren_city, r.ren_state, r.ren_zip, r.ren_description, r.community_fk, r.ren_cost, r.bed_fk, r.bath_fk, r.garage_fk, r.school_grade_fk, r.school_middle_fk, r.school_high_fk, r.home_type_fk, r.sq_ft_fk, r.created_at, r.updated_at, r.deleted_at
                      FROM rentals r
                     WHERE 0=0
                     <cfif #arguments.rental_id# neq "">
                       AND r.rental_id = <cfqueryparam value = "#arguments.rental_id#" cfsqltype = "cf_sql_integer"> 
                     </cfif>
                     
                     <cfif #arguments.admin_fk# neq "">
                       AND r.admin_fk = <cfqueryparam value = "#arguments.admin_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif>

                     <cfif #arguments.ren_address# neq "">
                       AND r.ren_address LIKE <cfqueryparam value = "%#arguments.ren_address#%" cfsqltype = "cf_sql_string"> 
                     </cfif>
                     <cfif #arguments.bed_fk# neq "">
                       AND r.bed_fk = <cfqueryparam value = "#arguments.bed_fk#" cfsqltype = "cf_sql_string"> 
                     </cfif>
    
                     <cfif #arguments.bath_fk# neq "">
                       AND r.bath_fk = <cfqueryparam value = "#arguments.bath_fk#" cfsqltype = "cf_sql_string"> 
                     </cfif>
        
                     <cfif #arguments.community_fk# neq "">
                       AND r.community_fk = <cfqueryparam value = "#arguments.community_fk#" cfsqltype = "cf_sql_string"> 
                     </cfif>             

                     <cfif #arguments.garage_fk# neq "">
                       AND r.garage_fk = <cfqueryparam value = "#arguments.garage_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 

                     <cfif #arguments.sq_ft_fk# neq "">
                       AND r.sq_ft_fk = <cfqueryparam value = "#arguments.sq_ft_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 
 
                     <cfif #arguments.school_grade_fk# neq "">
                       AND r.school_grade_fk = <cfqueryparam value = "#arguments.school_grade_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif>  

				     <cfif #arguments.school_middle_fk# neq "">
                       AND r.school_middle_fk = <cfqueryparam value = "#arguments.school_middle_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 

                      <cfif #arguments.school_high_fk# neq "">
                       AND r.school_high_fk = <cfqueryparam value = "#arguments.school_high_fk#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 

                     <cfif #arguments.ren_zip# neq "">
                       AND r.ren_zip = <cfqueryparam value = "#arguments.ren_zip#" cfsqltype = "cf_sql_integer"> 
                     </cfif> 
                     
                     <cfif #arguments.order_random# neq "">
                  ORDER BY RAND()                    
                     <cfelse>
                  ORDER BY created_at
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
        
        <cfargument name="ri_image1" type="string" required="no" default="">
        <cfargument name="ri_image2" type="string" required="no" default="">
        <cfargument name="ri_image3" type="string" required="no" default="">
        <cfargument name="ri_image4" type="string" required="no" default="">
        <cfargument name="ri_image5" type="string" required="no" default="">
              
        <cfargument name="ri_image1_org" type="string" required="no" default="">
        <cfargument name="ri_image2_org" type="string" required="no" default="">
        <cfargument name="ri_image3_org" type="string" required="no" default="">
        <cfargument name="ri_image4_org" type="string" required="no" default="">
        <cfargument name="ri_image5_org" type="string" required="no" default="">
               
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "property_updated">
 
        <!--- random string for naming images --->
        <cfinvoke 
            component="#request.cfc#._helpers"
            method="random_string_Helpers" 
            returnvariable="string_is">
        </cfinvoke>
 
		<!-- INSERT IMAGE START --->
		<!------------------------->	
		<cfif #arguments.ri_image1# neq "">
			
	        <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="delete"
            	rental_fk=#arguments.rental_id#
            	ri_order='1'
            	image=#arguments.ri_image1_org#>
			</cfinvoke>	
				
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image1" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='1'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#arguments.rental_id#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

		<cfif #arguments.ri_image2# neq "">
			<cfinvoke
            	component="#request.cfc#.rental_images"
            	method="delete"
            	rental_fk=#arguments.rental_id#
            	ri_order='2'
            	image=#arguments.ri_image2_org#>
			</cfinvoke>
			
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image2" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='2'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#arguments.rental_id#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

        <cfif #arguments.ri_image3# neq "">

			<cfinvoke
            	component="#request.cfc#.rental_images"
            	method="delete"
            	rental_fk=#arguments.rental_id#
            	ri_order='3'
            	image=#arguments.ri_image3_org#>
			</cfinvoke>
						
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image3" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='3'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#arguments.rental_id#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->        
		<!-- INSERT IMAGE END --->
		<!----------------------->	

		<cfif #arguments.ri_image4# neq "">

			<cfinvoke
            	component="#request.cfc#.rental_images"
            	method="delete"
            	rental_fk=#arguments.rental_id#
            	ri_order='4'
            	image=#arguments.ri_image4_org#>
			</cfinvoke>
						
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image4" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='4'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#arguments.rental_id#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> --->

      	<cfif #arguments.ri_image5# neq "">

			<cfinvoke
            	component="#request.cfc#.rental_images"
            	method="delete"
            	rental_fk=#arguments.rental_id#
            	ri_order='5'
            	image=#arguments.ri_image5_org#>
			</cfinvoke>
						
			<!--- upload the image --->
            <cffile action="upload" filefield="ri_image5" nameconflict="makeunique" destination="#request.upLoadRoot#assets\images\temp\"></cffile>
            
            <cfset image = "#cffile.serverFile#">
            <cfset save_image = "#string_is##cffile.serverFile#">
            
            <cfinvoke
            	component="#request.cfc#.rental_images"
            	method="create"
            	ri_order='5'
            	image=#image#
            	save_image=#save_image#
            	rental_fk=#arguments.rental_id#>
			</cfinvoke>
            		
        </cfif><!--- // <cfif isDefined ('argument.ss_image') and #argument.ss_image# neq ""> ---> 
          						
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
		
        <cfargument name="rental_id" type="string" required="yes" >
        <cfargument name="deleted_at" type="string" required="no" default="#DateFormat(now(), "yyyy-mm-dd")#">
        				
		<!--- result structure --->
        <cfset result = structNew()>
        <cfset result.status = "deleted">

		<cftry>
			<cflock name="delete_to_table" type="exclusive" timeout="5">	
				
                <cfquery datasource="#request.DSN#">
                    UPDATE rental
                       SET deleted_at = <cfqueryparam value = "#arguments.deleted_at#" cfsqltype="cf_sql_varchar">
                     WHERE rental_id = <cfqueryparam value="#arguments.rental_id#" cfsqltype="cf_sql_integer"> 
				</cfquery> 
                	
			</cflock>	
            <cfcatch type="any">

                <cfset result.status = "error_deleting">

                <cfif #request.debug# eq "On">
                    <cfrethrow />	
                </cfif>
            
            </cfcatch>
		</cftry>	
		
        <cfreturn result>
        
	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->    

	<cffunction name="display_search_breadcrumbs" returntype="string">
		
		<cfoutput>
		<cfif #url.alias# eq "Search-Results" or #url.alias# eq "Map-Properties">
			<strong>Search Criteria:</strong> 
			<br />
			
			<div class="well">
			
			<cfif isDefined('session.ren_address') and #session.ren_address# neq "">
				<span class="tag label label-info">
				  <span>#session.ren_address#</span>
				  <a href="#url.alias#&clear=ren_address"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.bed_fk') and #session.bed_fk# neq "">	
	  			<cfinvoke
		  			component="#request.cfc#.beds"
		  			method="read"
		  			bed_id=#session.bed_fk#
		  			returnvariable="data_beds">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_beds">
			  			#data_beds.b_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=bed_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.bath_fk') and #session.bath_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.baths"
		  			method="read"
		  			bath_id=#session.bath_fk#
		  			returnvariable="data_baths">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_baths">
			  			#data_baths.b_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=bath_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.community_fk') and #session.community_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.communities"
		  			method="read"
		  			community_id=#session.community_fk#
		  			returnvariable="data_communities">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_communities">
			  			#data_communities.com_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=community_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.garage_fk') and #session.garage_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.garages"
		  			method="read"
		  			garage_id=#session.garage_fk#
		  			returnvariable="data_garages">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_garagess">
			  			#data_garages.ga_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=garage_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.sq_ft_fk') and #session.sq_ft_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.sq_ft"
		  			method="read"
		  			sq_ft_id=#session.sq_ft_fk#
		  			returnvariable="data_sq_ft">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_sq_ft">
			  			#data_sq_ft.sq_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=sq_ft_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.school_grade_fk') and #session.school_grade_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.school_grade"
		  			method="read"
		  			school_grade_id=#session.school_grade_fk#
		  			returnvariable="data_school_grade">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_school_grade">
			  			#data_school_grade.sg_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=school_grade_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.school_middle_fk') and #session.school_middle_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.school_middle"
		  			method="read"
		  			school_middle_id=#session.school_middle_fk#
		  			returnvariable="data_school_middle">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_school_middle">
			  			#data_school_middle.sm_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=school_middle_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.school_high_fk') and #session.school_high_fk# neq "">
				<cfinvoke
		  			component="#request.cfc#.school_high"
		  			method="read"
		  			school_high_id=#session.school_high_fk#
		  			returnvariable="data_school_high">
		  		</cfinvoke>
			  	<span class="tag label label-info">
				  	<span>
					<cloop query="data_school_high">
			  			#data_school_high.sh_name#
			  		</cloop>
					</span>
				  <a href="#url.alias#&clear=school_high_fk"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			<cfif isDefined('session.ren_zip') and #session.ren_zip# neq "">
				<span class="tag label label-info">
				  <span>#session.ren_zip#</span>
				  <a href="#url.alias#&clear=ren_zip"><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a> 
				</span>
			</cfif>
			
			</div><!--- <div class="well"> --->
			
			<br /><br />
		</cfif>
		</cfoutput>
        
	</cffunction>
      
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ---> 

</cfcomponent>
