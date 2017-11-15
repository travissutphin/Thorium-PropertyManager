<cfcomponent displayname="Communities Table" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="create" returntype="struct">
        
	</cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="read" returntype="query">
		
        <cfargument name="community_id" type="string" required="false" default="">
        
        <cfquery name="query" datasource="#request.DSN#">
			
            SELECT community_id, com_name, com_order
			  FROM communities
             WHERE 0=0
			 <cfif #arguments.community_id# neq "">
               AND community_id = <cfqueryparam value = "#arguments.community_id#" cfsqltype = "cf_sql_integer"> 
             </cfif>
          ORDER BY com_order 
                           
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

	<cffunction name="html_select_communities" returntype="string">
		
		<cfargument name="community_fk" required="no" default="0">

		<cfinvoke 
            component="#request.cfc#.communities"
            method="read"
            returnvariable="records_Communities">
       	</cfinvoke>
       			
		<select name="community_fk" class="form-control">
        	<option value="">Select Community</option>
			<cfoutput query="records_Communities">
				<option value="#records_Communities.community_id#" <cfif #records_Communities.community_id# eq #arguments.community_fk#>selected</cfif> >#records_Communities.com_name#</option>
			</cfoutput>
        </select>
		
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->

</cfcomponent>
