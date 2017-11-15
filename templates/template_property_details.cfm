<cfoutput>   
    <div class="row">
    <div class="col-sm-6 col-md-3">
        <div class="module">
            <div class="module-info center vertical-align min-width">
                Cost
            </div><!--- /.module-info --->

            <div class="module-content vertical-align">
                <span>$#records_Property_Details.ren_cost#</span>
            </div><!--- /.module-content --->
        </div><!---- /.module --->
    </div>

    <div class="col-sm-6 col-md-3">
        <div class="module">
            <div class="module-info center vertical-align min-width">
                Size
            </div><!--- /.module-info --->

            <div class="module-content vertical-align">
                <cfinvoke
                	component="#request.cfc#.sq_ft"
                	method="read"
                	sq_ft_id="#records_Property_Details.sq_ft_fk#"
                	returnvariable="records_sq_ft">
                </cfinvoke>
                <cfloop query="records_sq_ft">
                	<span>#records_sq_ft.sq_name#</span>
                </cfloop>
            </div><!--- /.module-content --->
        </div><!---- /.module --->
    </div>

    <div class="col-sm-6 col-md-3">
        <div class="module">
            <div class="module-info center vertical-align min-width">
                Baths
            </div><!--- /.module-info --->

            <div class="module-content vertical-align">
                <cfinvoke
                	component="#request.cfc#.baths"
                	method="read"
                	bath_id="#records_Property_Details.bath_fk#"
                	returnvariable="records_bath">
                </cfinvoke>
                <cfloop query="records_bath">
                	<cfset baths = "#records_bath.b_value#">
                	<span>#records_bath.b_value#</span>
                </cfloop>
            </div><!--- /.module-content --->
        </div><!---- /.module --->
    </div>

    <div class="col-sm-6 col-md-3">
        <div class="module">
            <div class="module-info center vertical-align min-width">
                Beds
            </div><!--- /.module-info --->

            <div class="module-content vertical-align">
                <cfinvoke
                	component="#request.cfc#.beds"
                	method="read"
                	bed_id="#records_Property_Details.bed_fk#"
                	returnvariable="records_bed">
                </cfinvoke>
                <cfloop query="records_bed">
                	<cfset beds = "#records_bed.b_value#">
                	<span>#records_bed.b_value#</span>
                </cfloop>
            </div><!--- /.module-content --->
        </div><!---- /.module --->
    </div>
</div><!--- /.row --->

   
   	<cfinvoke 
		component="#request.cfc#.rental_images"
		method="read" 
		rental_fk = '#records_Property_Details.rental_id#'
		returnvariable="records_Rental_Images" >
	</cfinvoke>
   
    <div class="row">
    <div class="col-sm-12 col-md-7">
        <div class="property-gallery">
            <div class="property-gallery-preview">
                <a href="properties-detail.html##">
                    <cfif #records_Rental_Images.ri_image# neq "">
                    	<img class="img-responsive" src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" alt="">
                    </cfif>
                </a>
            </div><!--- /.property-gallery-preview --->

            <div class="property-gallery-list-wrapper">
                <div class="property-gallery-list">
                    
                    <cfloop query="records_Rental_Images">
                    <div class="property-gallery-list-item">
                        <a href="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#">
                            <img class="img-responsive" src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" alt="">
                        </a>
                    </div>
                    </cfloop>

                </div><!--- /.property-gallery-list --->
            </div><!--- /.property-gallery-list-wrapper --->
        </div><!--- /.property-gallery --->
    </div>

    <div class="col-sm-12 col-md-5">
        <div class="property-list">
            <dl>
                <dt>Monthly Rent</dt><dd>$ #records_Property_Details.ren_cost#</dd>
                <dt>Address</dt><dd> #records_Property_Details.ren_address#</dd>
                <dt>City</dt><dd> #records_Property_Details.ren_city# #records_Property_Details.ren_zip#</dd>
                <dt>Community</dt>
                	<dd>
					<cfinvoke
						component="#request.cfc#.communities"
						method="read"
						community_id="#records_Property_Details.community_fk#"
						returnvariable="records_community">
					</cfinvoke>
					<cfloop query="records_community">
						<span>#records_community.com_name#</span>
					</cfloop>
               		</dd>
                <!---<dt>Agency</dt><dd>Real Estate Express</dd>--->
                <dt>Type</dt>
                <dd>
				<cfinvoke
                	component="#request.cfc#.home_type"
                	method="read"
                	home_type_id="#records_Property_Details.home_type_fk#"
                	returnvariable="records_home_type">
                </cfinvoke>
                <cfloop query="records_home_type">
                	<span>#records_home_type.ht_name#</span>
                </cfloop>
               	</dd>
                <dt>Garages</dt><dd>#records_Property_Details.garage_fk#</dd>
                <dt>Baths</dt><dd>#baths#</dd>
                <dt>Beds</dt><dd>#beds#</dd>
            </dl>
        </div><!--- /.property-list --->

        <!---
        <h2 class="mb30">Social Profiles</h2>

        <ul class="clearfix sharing-buttons">
            <li>
                <a class="facebook" href="https://www.facebook.com/share.php?u=http://html.realsite.byaviators.com&amp;title=Realsite%20-%20Material%20Real%20Estate%20HTML%20Template##sthash.BUkY1jCE.dpuf"  onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                    <i class="fa fa-facebook fa-left"></i>
                    <span class="social-name">Facebook</span>
                </a>
            </li>
            <li>
                <a class="google-plus" href="https://plus.google.com/share?url=http://html.realsite.byaviators.com" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                    <i class="fa fa-google-plus fa-left"></i>
                    <span class="social-name">Google+</span>
                </a>
            </li>
            <li>
                <a class="twitter" href="https://twitter.com/home?status=Realsite%20-%20Material%20Real%20Estate%20HTML%20Template+http://html.realsite.byaviators.com##sthash.BUkY1jCE.dpuf"  onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                    <i class="fa fa-twitter fa-left"></i>
                    <span class="social-name">Twitter</span>
                </a>
            </li>
        </ul>--->
        
    </div>
</div><!--- /.row --->
    
    <div class="mb30">
    <h2>Description</h2>

    <p class="text">
       <cfset description = paragraphFormat(#records_Property_Details.ren_description#)/>
       <cfset description = #replace(description,"<p>","<p class='text'","all")#/>
       #description#
    </p>
    
</div>

    <h2 class="page-header">Amenities</h2>

    <cfinvoke
    	component="#request.cfc#.amenities"
    	method="html_property_details_checked_amenities"
    	rental_fk="#records_Property_Details.rental_id#">
    </cfinvoke>

    <h2 class="page-header">Position on Map</h2>
	<div class="map-property">
		<div id="map_canvas"></div><!--- /##map-property --->
	</div>

    <div class="module">
    <div class="module-content">
        <div class="agent-card">
            <div class="row">
                <div class="col-sm-12 col-md-4 mb30">
                    <a href="properties-detail.html##" class="agent-card-image">
                        <img src="assets/img/tmp/agents/female.jpg" alt="">
                    </a><!--- /.agent-card-image --->
                </div>

                <div class="col-sm-12 col-md-3">
                    <h2>Information</h2>

                    <div class="agent-card-info">
                        <ul>
                            <li>#records_Admin.a_name_first# #records_Admin.a_name_last#</li>
                        </ul>

                        <br>

                        <ul>
                            <li><i class="fa fa-phone"></i> 0123 123 123</li>
                            <li><i class="fa fa-at"></i> <a href="properties-detail.html##">E-mail address</a></li>
                            <li><i class="fa fa-globe"></i> <a href="http://example.com">example.com</a></li>
                        </ul>
                    </div><!--- /.agent-card-info --->
                </div>

                <div class="col-sm-12 col-md-5 mb30">
                    <h2>Contact Form</h2>

                    <div class="agent-card-form">
                        <form method="post" action="http://html.realsite.byaviators.com/properties-detail.html?">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Subject">
                            </div><!--- /.form-group --->

                            <div class="form-group">
                                <input type="email" class="form-control" placeholder="E-mail">
                            </div><!--- /.form-group --->

                            <div class="form-group">
                                <textarea class="form-control" placeholder="Message"></textarea>
                            </div><!--- /.form-group --->
                        </form>
                    </div><!--- /.agent-card-form --->
                </div>
            </div>
        </div><!--- /.agent-card--->
    </div><!--- /.module-content --->
</div><!--- /.module --->

   
</div><!--- /.module --->

<!--- google map --->		   
<script>

  function initMap() {
	var myLatLng = {lat: #records_Property_Details.ren_latitude#, lng: #records_Property_Details.ren_longitude#};

	var map = new google.maps.Map(document.getElementById('map_canvas'), {
	  zoom: 12,
	  center: myLatLng
	});

	var marker = new google.maps.Marker({
	  position: myLatLng,
	  map: map,
	  title: ''
	});
  }
</script>
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA9Uf5xsgRhoylWuN6mtze9XTcVTNaPELI&callback=initMap">
</script>

</cfoutput>