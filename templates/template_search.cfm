<cfoutput>
<div class="widget-title">
	<h2>Search Rentals</h2>
</div><!--/.widget-title -->

<div class="widget-content">

	<form method="post" action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>?id=10">
		<div class="form-group">
			<input type="text" class="form-control" placeholder="Address">
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#._helpers"
				method="beds_Helpers"
				ren_beds_fk = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#._helpers"
				method="baths_Helpers"
				ren_baths_fk = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#.communities"
				method="html_select_communities"
				community_id = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#._helpers"
				method="sq_ft_Helpers"
				ren_sq_ft = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#.school_grade"
				method="html_select_school_grade"
				school_grade_id = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#.school_middle"
				method="html_select_school_middle"
				school_middle_id = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfinvoke 
				component="#request.cfc#.school_high"
				method="html_select_school_high"
				school_high_id = ''>
			</cfinvoke>
		</div><!-- /.form-group -->

		<button class="btn btn-lg btn-block">Search</button>
	</form>

</div><!-- /.widget-content -->
</cfoutput>