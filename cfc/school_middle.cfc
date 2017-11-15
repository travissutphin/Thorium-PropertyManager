<cfcomponent displayname="School_Middle Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="school_middle_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT school_middle_id, sm_name
			  FROM school_middle
             WHERE 0=0
			 <cfif #arguments.school_middle_id# neq "">
               AND school_middle_id = <cfqueryparam value = "#arguments.school_middle_id#" cfsqltype = "cf_sql_integer"> 
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

	<cffunction name="html_select_school_middle" returntype="string">
		
		<cfargument name="school_middle_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.school_middle"
            method="read"
            returnvariable="records_School_Middle">
       	</cfinvoke>
       			
		<select name="school_middle_fk" class="form-control">
        	<option value="">Select Middle School</option>
			<cfoutput query="records_School_Middle">
				<option value="#records_School_Middle.school_middle_id#" <cfif #records_School_Middle.school_middle_id# eq #arguments.school_middle_fk#>selected</cfif> >#records_School_Middle.sm_name#</option>
			</cfoutput>
        </select>
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
