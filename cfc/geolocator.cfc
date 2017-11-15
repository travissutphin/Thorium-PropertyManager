<cfcomponent displayname="Geolocator Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="geolocator_id" type="string" required="false" default="">
       	<cfargument name="ge_city" type="string" required="false" default="">
        <cfargument name="ge_state" type="string" required="false" default="">
  		<cfargument name="ge_zipcode" type="string" required="false" default="">
       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT DISTINCT ge_zipcode
			  FROM geolocator
             WHERE 0=0
			 <cfif #arguments.geolocator_id# neq "">
               AND geolocator_id = <cfqueryparam value = "#arguments.geolocator_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
                          
             <cfif #arguments.ge_city# neq "">
               AND ge_city = <cfqueryparam value = "#arguments.ge_city#" cfsqltype = "cf_sql_varchar"> 
             </cfif>
             
             <cfif #arguments.ge_state# neq "">
               AND ge_state = <cfqueryparam value = "#arguments.ge_state#" cfsqltype = "cf_sql_varchar"> 
             </cfif>

             <cfif #arguments.ge_zipcode# neq "">
               AND ge_zipcode = <cfqueryparam value = "#arguments.ge_zipcode#" cfsqltype = "cf_sql_varchar"> 
             </cfif>
             
          ORDER BY ge_zipcode
                                                                             
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

	<cffunction name="html_select_zip_codes_geolocator" returntype="string">
		
		<cfargument name="ren_zip" required="no" default="">

		<cfinvoke 
            component="#request.cfc#.geolocator"
            method="read"
            ge_city="SAINT AUGUSTINE"
            ge_state="FL"
            returnvariable="records_Geolocator">
       	</cfinvoke>
       			
		<select name="ren_zip" class="form-control">
        	<option value="">Zipcode</option>
			<cfoutput query="records_Geolocator">
				<option value="#records_Geolocator.ge_zipcode#" <cfif #records_Geolocator.ge_zipcode# eq #arguments.ren_zip#>selected</cfif> >#records_Geolocator.ge_zipcode#</option>
			</cfoutput>
        </select>		
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
