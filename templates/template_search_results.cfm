<cfoutput>
<h4>
<cfif isDefined('records_Rentals.recordcount')>#records_Rentals.recordcount# Results </cfif>
<cfif isDefined('order_random')>Showing all Rentals in a random order</cfif>
</h4>

<cfinvoke 
	component="#request.cfc#.rentals"
	method="display_search_breadcrumbs">
</cfinvoke>


<cfif isDefined('records_Rentals.rental_id')>
 <div class="row">
  <cfloop query="records_Rentals">

	<cfinvoke 
		component="#request.cfc#.rental_images"
		method="read" 
		rental_fk = '#records_Rentals.rental_id#'
		returnvariable="records_Rental_Images" >
	</cfinvoke>
				
    <div class="col-sm-6 col-md-4">
        <div class="property-box">
            <div class="property-box-image">
                <a href="properties-grid.html##">
                    <cfif #records_Rental_Images.ri_image# neq "">
                    	<img src="#Request.siteURL#assets/images/uploads/#records_Rental_Images.ri_image#" width="220" height="148" alt="">
					<cfelse>
                   		<img src="#Request.siteURL#assets/images/uploads/OEOsspace011.jpg" alt="">
                   	</cfif>
                    <span class="property-box-excerpt">
                        #records_Rentals.ren_description#
                    </span>
                </a>
            </div><!-- /.property-image -->

            <div class="property-box-content">
                <div class="property-box-meta">
                    <div class="property-box-meta-item">
                        <span>Baths</span>
                        <cfinvoke
                        	component="#request.cfc#.baths"
                        	method="read"
                        	bath_id="#records_Rentals.bath_fk#"
                        	returnvariable="return_value">
                        </cfinvoke>
                        <cfloop query="return_value">
                        	<strong>#return_value.b_value#</strong>
                        </cfloop>                       
                    </div><!-- /.property-box-meta-item -->

                    <div class="property-box-meta-item">
                        <span>Beds</span>
                        <cfinvoke
                        	component="#request.cfc#.beds"
                        	method="read"
                        	bed_id="#records_Rentals.bed_fk#"
                        	returnvariable="return_value">
                        </cfinvoke>
                        <cfloop query="return_value">
                        	<strong>#return_value.b_value#</strong>
                        </cfloop>
                    </div><!-- /.property-box-meta-item -->

                    <div class="property-box-meta-item">
                        <span>Garages</span>
                        <cfinvoke
                        	component="#request.cfc#.garages"
                        	method="read"
                        	garage_id="#records_Rentals.garage_fk#"
                        	returnvariable="return_value">
                        </cfinvoke>
                        <cfloop query="return_value">
                        	<strong>#return_value.ga_value#</strong>
                        </cfloop>
                    </div><!-- /.property-box-meta-item -->
                </div><!-- /.property-box-meta -->
            </div><!-- /.property-box-content -->

           <div class="property-box-bottom">
                <div class="property-box-price">
                    
                    <cfinvoke
                    	component="#request.cfc#.communities"
                        method="read"
                       	community_id="#records_Rentals.community_fk#"
                       	returnvariable="return_value">
					</cfinvoke>
					<cfloop query="return_value">
						#return_value.com_name# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</cfloop>
               
                </div><!-- /.property-box-price -->

                <a href="https://www.google.com/maps/place/#records_Rentals.ren_address#, #records_Rentals.ren_city#,  #records_Rentals.ren_state#, #records_Rentals.ren_zip#" target="_blank" class="property-box-view">
                    <br />#records_Rentals.ren_address#
                    <br />#records_Rentals.ren_city# #records_Rentals.ren_state#
					#records_Rentals.ren_zip#
                </a><!-- /.property-box-view -->
                
            </div><!-- /.property-box-bottom -->
            
            <div class="property-box-bottom">
                <div class="property-box-price">
                    $ #records_Rentals.ren_cost#
                </div><!-- /.property-box-price -->

                <form name="property_details" method="post" action="Property-Details">
                	<input type="submit" class="btn btn-sm pull-right" value="View Details">
                	<input name="rental_id" type="hidden" value="#records_Rentals.rental_id#">
                </form>
                
            </div><!-- /.property-box-bottom -->
        </div><!-- /.property-box -->
    </div>
	   </cfloop>
</div>
</cfif>
</cfoutput>
<style>
	/***** My Classes *****/
.tag {
  font-size: 14px;
  padding: .3em .4em .4em;
  margin: 0 .1em;
}
.tag a {
  color: #bbb;
  cursor: pointer;
  opacity: 0.6;
}
.tag a:hover {
  opacity: 1.0
}
.tag .remove {
  vertical-align: bottom;
  top: 0;
}
.tag a {
  margin: 0 0 0 .3em;
}
.tag a .glyphicon-white {
  color: #fff;
  margin-bottom: 6px;
}</style>