<cfcomponent displayname="Sq_Ft Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="sq_ft_id" type="string" required="false" default="">
        		       
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT sq_ft_id, sq_name
			  FROM sq_ft
             WHERE 0=0
			 <cfif #arguments.sq_ft_id# neq "">
               AND sq_ft_id = <cfqueryparam value = "#arguments.sq_ft_id#" cfsqltype = "cf_sql_integer"> 
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

	<cffunction name="html_select_sq_ft" returntype="string">
		
		<cfargument name="sq_ft_fk" required="no">

		<cfinvoke 
            component="#request.cfc#.sq_ft"
            method="read"
            returnvariable="records_Sq_Ft">
       	</cfinvoke>
       			
		<select name="sq_ft_fk" class="form-control">
        	<option value="">Sq Ft</option>
			<cfoutput query="records_Sq_Ft">
				<option value="#records_Sq_Ft.sq_ft_id#" <cfif #records_Sq_Ft.sq_ft_id# eq #arguments.sq_ft_fk#>selected</cfif> >#records_Sq_Ft.sq_name#</option>
			</cfoutput>
        </select>		
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
