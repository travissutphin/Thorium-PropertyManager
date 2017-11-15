<cfoutput>

<cfif isDefined('show_message')>
	#show_message#
</cfif>
        
<!--- ADD/EDIT PROPERTY --->
<!------------------------->
<cfif isDefined('FORM.property_add') or isDefined('FORM.property_edit')>

	<form name="property_submit" method="post" enctype="multipart/form-data" action="Manage-My-Properties">

		<h1 class="page-header">
			<cfif isDefined('FORM.property_edit')>
				Edit Your Property
			<cfelse>
				Create New Property
			</cfif>
		</h1>

		<div class="box">

		<div class="form-group">
			<cfif isDefined('FORM.property_edit')>
				<cfset value = "#records_Rentals.ren_description#">
			<cfelse>
				<cfset value = ''>
			</cfif>
			
			<textarea onkeyup="textCounter(this,'counter',1500);" name="ren_description" class="form-control" placeholder="Rental Property Description (Max 1500 Characters)">#value#</textarea>
			<input class="form-group" disabled  maxlength="3" size="3" value="1500" id="counter"> Characters left
			<cfset script_text_counter = TRUE><!--- script is at bottom of index page --->
			
		</div><!-- /.form-group -->
	</div><!-- /.box -->

	<h2 class="page-header">Attributes</h2>

	<div class="box">
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.home_type_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.home_type"
						method="html_select_home_type"
						home_type_fk = "#value#">
					</cfinvoke>

				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.ren_address#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<input name="ren_address" class="form-control" type="text" placeholder="Address" value="#value#">
				</div><!-- /.form-group -->

				<div class="form-group">
					<input name="ren_city" class="form-control" type="text" value="St. Augustine" readonly>
				</div><!-- /.form-group -->

				<div class="form-group">
					<input name="ren_state" class="form-control" type="text" value="FL" readonly>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.ren_zip#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.geolocator"
						method="html_select_zip_codes_geolocator"
						ren_zip = '#value#'>
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.community_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>					
					<cfinvoke 
						component="#request.cfc#.communities"
						method="html_select_communities"
						community_fk="#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.school_grade_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>	
					<cfinvoke 
						component="#request.cfc#.school_grade"
						method="html_select_school_grade"
						school_grade_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.school_middle_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.school_middle"
						method="html_select_school_middle"
						school_middle_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.school_high_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.school_high"
						method="html_select_school_high"
						school_high_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

			</div><!-- /.col-* -->

			<div class="col-sm-6">
				<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.ren_cost#">
					<cfelse>
						<cfset value = ''>
					</cfif>
				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-dollar"></i></span>
					<input name="ren_cost" class="form-control" type="text" placeholder="Monthly Rent" value="#value#">
				</div><!-- /.form-group -->
				
				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.sq_ft_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.sq_ft"
						method="html_select_sq_ft"
						sq_ft_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.bath_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.baths"
						method="html_select_bath"
						bath_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.bed_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.beds"
						method="html_select_bed"
						bed_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->

				<div class="form-group">
					<cfif isDefined('FORM.property_edit')>
						<cfset value = "#records_Rentals.garage_fk#">
					<cfelse>
						<cfset value = ''>
					</cfif>
					<cfinvoke 
						component="#request.cfc#.garages"
						method="html_select_garage"
						garage_fk = "#value#">
					</cfinvoke>
				</div><!-- /.form-group -->
				
			</div><!-- /.col-* -->
		</div><!-- /.row -->
	</div><!-- /.box -->

	<div class="row">
		
		<!---
		<div class="col-sm-12">
			<h2 class="page-header">Map Position</h2>

			<div class="box">
				<input id="pac-input" class="controls" type="text" placeholder="Enter a location">

				<div id="map-canvas"></div>

				<div class="row">
					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-map-marker"></i></span>
							<input class="form-control" type="text" placeholder="Latitude" id="input-latitude">
						</div><!-- /.form-group ->
					</div><!-- /.col-* ->

					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-map-marker"></i></span>
							<input class="form-control" type="text" placeholder="Lontgitude" id="input-longitude">
						</div><!-- /.form-group ->
					</div><!-- /.col-* ->
				</div><!-- /.row ->
			</div><!-- /.box ->
		</div>
		--->
		
		<div class="col-sm-12">
			<h2 class="page-header">Additional Images</h2>
			
			<div class="col-sm-3 well">
				<input name="ri_image1" id="files" type="file" />
				<cfif isDefined('FORM.property_edit')>
					<cfloop query="records_Rental_Images">
						<cfif #records_Rental_Images.ri_order# eq '1' and #records_Rental_Images.ri_image# neq "">
							<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="150" height="105">
							<input name="ri_image1_org" type="hidden" value="#records_Rental_Images.ri_image#">
						</cfif>
					</cfloop> 
				</cfif> 
			</div>
			<div class="col-sm-3 well">
				<input name="ri_image2" id="files" type="file" />
				<cfif isDefined('FORM.property_edit')>
					<cfloop query="records_Rental_Images">
						<cfif #records_Rental_Images.ri_order# eq '2' and #records_Rental_Images.ri_image# neq "">
							<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="150" height="105">
							<input name="ri_image2_org" type="hidden" value="#records_Rental_Images.ri_image#">
						</cfif>
					</cfloop> 
				</cfif> 
			</div>
			<div class="col-sm-3 well">
				<input name="ri_image3" id="files" type="file" />
				<cfif isDefined('FORM.property_edit')>
					<cfloop query="records_Rental_Images">
						<cfif #records_Rental_Images.ri_order# eq '3' and #records_Rental_Images.ri_image# neq "">
							<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="150" height="105">
							<input name="ri_image3_org" type="hidden" value="#records_Rental_Images.ri_image#">
						</cfif>
					</cfloop> 
				</cfif> 
			</div>
			<div class="col-sm-3 well">
				<input name="ri_image4" id="files" type="file" />
				<cfif isDefined('FORM.property_edit')>
					<cfloop query="records_Rental_Images">
						<cfif #records_Rental_Images.ri_order# eq '4' and #records_Rental_Images.ri_image# neq "">
							<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="150" height="105">
							<input name="ri_image4_org" type="hidden" value="#records_Rental_Images.ri_image#">
						</cfif>
					</cfloop> 
				</cfif> 
			</div>
			<div class="col-sm-3 well">
				<input name="ri_image5" id="files" type="file" />
				<cfif isDefined('FORM.property_edit')>
					<cfloop query="records_Rental_Images">
						<cfif #records_Rental_Images.ri_order# eq '5' and #records_Rental_Images.ri_image# neq "">
							<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="150" height="105">
							<input name="ri_image5_org" type="hidden" value="#records_Rental_Images.ri_image#">
						</cfif>
					</cfloop> 
				</cfif> 
			</div>
		</div>
		
	</div><!-- /.row -->
		
		<h2 class="page-header">Amenities</h2>
		<cfif isDefined('FORM.property_edit')>
			<cfset value = "#records_Rentals.rental_id#">
		<cfelse>
			<cfset value = '0'>
		</cfif>
		<cfinvoke 
			component="#request.cfc#.amenities"
			method="html_checkbox_amenities"
			rental_fk = '#value#'>
		</cfinvoke>

	<div class="center">
		<cfif isDefined('FORM.property_edit')>
			<input type="submit" class="btn btn-xl" value="Update Property">
			<input type="hidden" name="property_update">
			<input type="hidden" name="rental_id" value="#records_Rentals.rental_id#">
 		<cfelse>
			<input type="submit" class="btn btn-xl" value="Submit Property">
			<input type="hidden" name="property_submit"> 
		</cfif>
		<!---<button class="btn btn-xl">Submit Property<small>I agree with Terms &amp; Conditions</small></button>--->
	</div><!-- /.center -->

	</form>


<!--- PROPERTY TABLE VIEW  --->
<!---------------------------->
<cfelse>
	
	<table class="property-table">
    <thead>
        <tr>
            <th>Info</th>
            <th class="center">Bath</th>
            <th class="center">Beds</th>
            <th colspan="2">
            	<form name="property_add" method="post" action="Manage-My-Properties">
            		<input type="submit" class="btn btn-sm pull-right" value="Add Property">
            		<input type="hidden" name="property_add">
            	</form>
            </th>
        </tr>
    </thead>

    <tbody>
    
		<cfloop query="records_Rentals">
			<tr>
			<td class="property-table-info">
				<!---
				<cfif #records_Rentals.ri_image# neq "">
					<a href="properties-table.html" class="property-table-info-image">
						<img src="#Request.siteURL#assets/images/uploads/#records_Rentals.ri_image#" alt="">
					</a>
				<cfelse>
					<a href="##" class="property-table-info-image">
						
					</a>
				</cfif>
				--->
				<div class="property-table-info-content">
					<div class="property-table-info-content-title">
						<cfinvoke 
							component="#request.cfc#.communities"
							method="read"
							community_id = "#records_Rentals.community_fk#"
							returnvariable = data_Community>
						</cfinvoke>
						<cfloop query="data_Community">
							#data_Community.com_name#
						</cfloop>
					</div><!-- /.property-table-info-content-title -->

					<ul class="property-table-info-content-location">
						<li><a href="properties-table.html"></a>&nbsp;</li>
						<li><a href="properties-table.html"></a>&nbsp;</li>
					</ul><!-- /.property-table-info-content-location -->

					<div class="property-table-info-content-price">
						<cfif #records_Rentals.ren_cost# gt 0>
							$ #records_Rentals.ren_cost#
						</cfif>
					</div>
				</div><!-- /.property-table-info-content -->
			</td>
			<td class="property-table-baths">
				<cfinvoke 
					component="#request.cfc#.baths"
					method="read"
					bath_id = "#records_Rentals.bath_fk#"
					returnvariable = data_Baths>
				</cfinvoke>
				<cfloop query="data_Baths">
					#data_Baths.b_name#
				</cfloop>
			</td>
			<td class="property-table-beds">
				<cfinvoke 
					component="#request.cfc#.beds"
					method="read"
					bed_id = "#records_Rentals.bed_fk#"
					returnvariable = data_Beds>
				</cfinvoke>
				<cfloop query="data_Beds">
					#data_Beds.b_name#
				</cfloop>				
			</td>
			<td>
				<span class="pull-right">
					<form name="property_edit" method="post" action="Manage-My-Properties">
						<input type="submit" class="btn btn-sm pull-right" value="Edit">
						<input type="hidden" name="property_edit">
						<input type="hidden" name="rental_id" value="#records_Rentals.rental_id#">
					</form>
				</td>
			</span>
			<td>
				<span class="pull-right">
					<form name="property_delete" method="post" action="Manage-My-Properties">
						<input type="submit" class="btn btn-sm pull-right" value="Delete">
						<input type="hidden" name="view_delete">
						<input type="hidden" name="rental_id" value="#records_Rentals.rental_id#">
					</form>
				</span>
			</td>
		</tr>
	</cfloop>

	</tbody>

</table><!-- /.properties-table -->
	
	
	
</cfif>

</cfoutput>

<!--- SAVE FOR MULTI IMAGE UPLOAD 
<article>
        <label for="files">Select multiple files: </label>
        <input name="myimage" id="files" type="file" multiple/>
        <output id="result" />
    </article>	
    
    
<script type='text/javascript'>//<![CDATA[

window.onload = function(){
        
    //Check File API support
    if(window.File && window.FileList && window.FileReader)
    {
        var filesInput = document.getElementById("files");

		            
        filesInput.addEventListener("change", function(event){
            
            var files = event.target.files; //FileList object
            var output = document.getElementById("result");

            for(var i = 0; i< files.length; i++)
            {
                var file = files[i];
                
                //Only pics
                if(!file.type.match('image'))
                  continue;
                
                var picReader = new FileReader();
                
                picReader.addEventListener("load",function(event){
                    
                    var picFile = event.target;
                    
                    var div = document.createElement("div");
                    
                    div.innerHTML = "<img width='150' class='thumbnail pull-left' src='" + picFile.result + "'" +
                            "title='" + picFile.name + "'/>";
                    
                    output.insertBefore(div,null);            
                
                });
                
                 //Read the image
                picReader.readAsDataURL(file);
            }                               
           
        });
    }
    else
    {
        console.log("Your browser does not support File API");
    }
}
    
//]]> 

</script>

  <script>
  // tell the embed parent frame the height of the content
  if (window.parent && window.parent.parent){
    window.parent.parent.postMessage(["resultsFrame", {
      height: document.body.getBoundingClientRect().height,
      slug: "Yvgc2"
    }], "*")
  }
</script>
--->