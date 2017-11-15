<cfcomponent displayname="Baths Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="bath_id" type="string" required="false" default="">
        		       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT bath_id, b_name, b_value
			  FROM baths
             WHERE 0=0
			 <cfif #arguments.bath_id# neq "">
               AND bath_id = <cfqueryparam value = "#arguments.bath_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
                           
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

	<cffunction name="html_select_bath" returntype="string">
		
		<cfargument name="bath_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.baths"
            method="read"
            returnvariable="records_Baths">
       	</cfinvoke>
       			
		<select name="bath_fk" class="form-control">
        	<option value="">Baths</option>
			<cfoutput query="records_Baths">
				<option value="#records_Baths.bath_id#" <cfif #records_Baths.bath_id# eq #arguments.bath_fk#>selected</cfif> >#records_Baths.b_name#</option>
			</cfoutput>
        </select>		
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
