<cfcomponent displayname="School_High Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="school_high_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT school_high_id, sh_name
			  FROM school_high
             WHERE 0=0
			 <cfif #arguments.school_high_id# neq "">
               AND school_high_id = <cfqueryparam value = "#arguments.school_high_id#" cfsqltype = "cf_sql_integer"> 
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

	<cffunction name="html_select_school_high" returntype="string">
		
		<cfargument name="school_high_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.school_high"
            method="read"
            returnvariable="records_School_High">
       	</cfinvoke>
       			
		<select name="school_high_fk" class="form-control">
        	<option value="">Select High School</option>
			<cfoutput query="records_School_High">
				<option value="#records_School_High.school_high_id#" <cfif #records_School_High.school_high_id# eq #arguments.school_high_fk#>selected</cfif> >#records_School_High.sh_name#</option>
			</cfoutput>
        </select>
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
