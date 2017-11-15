<cfcomponent displayname="Beds Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="bed_id" type="string" required="false" default="">
        		       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT bed_id, b_name, b_value
			  FROM beds
             WHERE 0=0
			 <cfif #arguments.bed_id# neq "">
               AND bed_id = <cfqueryparam value = "#arguments.bed_id#" cfsqltype = "cf_sql_integer"> 
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

	<cffunction name="html_select_bed" returntype="string">
		
		<cfargument name="bed_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.beds"
            method="read"
            returnvariable="records_Beds">
       	</cfinvoke>
       			
		<select name="bed_fk" class="form-control">
        	<option value="">Beds</option>
			<cfoutput query="records_Beds">
				<option value="#records_Beds.bed_id#" <cfif #records_Beds.bed_id# eq #arguments.bed_fk#>selected</cfif> >#records_Beds.b_name#</option>
			</cfoutput>
        </select>		
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
