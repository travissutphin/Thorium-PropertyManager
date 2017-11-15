<cfcomponent displayname="Home Type Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="home_type_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT home_type_id, ht_name
			  FROM home_type
             WHERE 0=0
			 <cfif #arguments.home_type_id# neq "">
               AND home_type_id = <cfqueryparam value = "#arguments.home_type_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
          ORDER BY ht_name        
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

	<cffunction name="html_select_home_type" returntype="string">
		
		<cfargument name="home_type_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.home_type"
            method="read"
            returnvariable="records_Home_Type">
       	</cfinvoke>
       			
		<select name="home_type_fk" class="form-control">
        	<option value="0">Select Property Type</option>
			<cfoutput query="records_home_type">
				<option value="#records_Home_Type.home_type_id#" <cfif #records_Home_Type.home_type_id# eq #arguments.Home_Type_fk#>selected</cfif> >#records_Home_Type.ht_name#</option>
			</cfoutput>
        </select>
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
