<cfcomponent displayname="Garages Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="garage_id" type="string" required="false" default="">
        		       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT garage_id, ga_name, ga_value
			  FROM garages
             WHERE 0=0
			 <cfif #arguments.garage_id# neq "">
               AND garage_id = <cfqueryparam value = "#arguments.garage_id#" cfsqltype = "cf_sql_integer"> 
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

	<cffunction name="html_select_garage" returntype="string">
		
		<cfargument name="garage_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.garages"
            method="read"
            returnvariable="records_Garages">
       	</cfinvoke>
       			
		<select name="garage_fk" class="form-control">
        	<option value="">Garages</option>
			<cfoutput query="records_Garages">
				<option value="#records_Garages.garage_id#" <cfif #records_Garages.garage_id# eq #arguments.garage_fk#>selected</cfif> >#records_Garages.ga_name#</option>
			</cfoutput>
        </select>		
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
