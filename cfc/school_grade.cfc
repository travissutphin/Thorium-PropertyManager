<cfcomponent displayname="School_Grade Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="school_grade_id" type="string" required="false" default="">
        		       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT school_grade_id, sg_name
			  FROM school_grade
             WHERE 0=0
			 <cfif #arguments.school_grade_id# neq "">
               AND school_grade_id = <cfqueryparam value = "#arguments.school_grade_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
          ORDER BY sg_name
                           
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

	<cffunction name="html_select_school_grade" returntype="string">
		
		<cfargument name="school_grade_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.school_grade"
            method="read"
            returnvariable="records_School_Grade">
       	</cfinvoke>
       			
		<select name="school_grade_fk" class="form-control">
        	<option value="">Select Grade School</option>
			<cfoutput query="records_School_Grade">
				<option value="#records_School_Grade.school_grade_id#" <cfif #records_School_Grade.school_grade_id# eq #arguments.school_grade_fk#>selected</cfif> >#records_School_Grade.sg_name#</option>
			</cfoutput>
        </select>
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
