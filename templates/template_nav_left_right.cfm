<cfoutput>

<cfif isDefined('SESSION.Auth.role_fk') and #SESSION.Auth.role_fk# eq '2'>
	<div class="widget-title">
		<h2>Welcome #SESSION.Auth.a_name_first#</h2>
	</div><!--/.widget-title -->
	<div class="widget-content">
		<a href="My-Profile">My Profile</a><br />
		<a href="Manage-My-Properties">Manage My Properties</a><br />
	</div><!-- /.widget-content -->
</cfif>


<div class="widget-title">
	<h2>Search Rentals</h2>
</div><!--/.widget-title -->

<div class="widget-content">

<cfif #url.alias# eq "Map-Properties">
	<cfset action = "Map-Properties">
<cfelse>
	<cfset action = "Search-Results">
</cfif>
	<form method="post" action="#action#">
		<div class="form-group">
			<input type="text" name="ren_address" class="form-control" placeholder="Address" value="<cfif isDefined('session.ren_address')>#session.ren_address#</cfif>">
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.bed_fk')>
				<cfset value = #session.bed_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.beds"
				method="html_select_bed"
				bed_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.bath_fk')>
				<cfset value = #session.bath_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.baths"
				method="html_select_bath"
				bath_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.community_fk')>
				<cfset value = #session.community_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.communities"
				method="html_select_communities"
				community_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.garage_fk')>
				<cfset value = #session.garage_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.garages"
				method="html_select_garage"
				garage_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->
		
		<div class="form-group">
			<cfif isDefined('session.sq_ft_fk')>
				<cfset value = #session.sq_ft_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.sq_ft"
				method="html_select_sq_ft"
				sq_ft_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.school_grade_fk')>
				<cfset value = #session.school_grade_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.school_grade"
				method="html_select_school_grade"
				school_grade_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.school_middle_fk')>
				<cfset value = #session.school_middle_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.school_middle"
				method="html_select_school_middle"
				school_middle_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.school_high_fk')>
				<cfset value = #session.school_high_fk#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.school_high"
				method="html_select_school_high"
				school_high_fk = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->

		<div class="form-group">
			<cfif isDefined('session.ren_zip')>
				<cfset value = #session.ren_zip#>
			<cfelse>
				<cfset value = ''>
			</cfif>
			<cfinvoke 
				component="#request.cfc#.geolocator"
				method="html_select_zip_codes_geolocator"
				ren_zip = '#value#'>
			</cfinvoke>
		</div><!-- /.form-group -->
		
		<input type="submit" name="search_results" value="Search">
		<input type="submit" name="search_clear" value="Clear">
		<!---<button class="btn btn-lg btn-block">Search</button>--->
	</form>

</div><!-- /.widget-content -->
</cfoutput>