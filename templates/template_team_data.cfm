<cfoutput>
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>        
<!--- Show Team Information --->
	
	<table class="table table-bordered table-hover table-responsive">
		<tr>
			<td>Name</td>
			<td>Cell</td>
			<td>Email</td>
			<td>Runner</td>
			<td></td>
		</tr>
	<cfloop query="records_Admin">
		<tr>
			<td>#records_Admin.a_name_first# #records_Admin.a_name_last#</td>
			<td>#records_Admin.a_cell#</td>
			<td>#records_Admin.a_email#</td>
			<td>#records_Admin.a_my_runner#<br />#records_Admin.a_my_runner_relationship_to#</td>
			<td>Delete</td>
		</tr>
	</cfloop>
	</table>
</cfoutput>