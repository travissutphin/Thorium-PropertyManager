   <div class="row">
 <cfoutput>
  <cfloop from="1" to="50" index="i">

    <div class="col-sm-6 col-md-4">
        <div class="property-box">
            <div class="property-box-image">
                <a href="properties-grid.html##">
                    <img src="assets/img/tmp/medium/1.jpg" alt="">

                    <span class="property-box-excerpt">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et ipsum nibh. Vivamus vehicula consequat justo, id molestie nisl feugiat dignissim. Nam a blandit leo, a porta nisl.
                    </span>
                </a>
            </div><!-- /.property-image -->

            <div class="property-box-content">
                <div class="property-box-meta">
                    <div class="property-box-meta-item">
                        <span>Baths</span>
                        <strong>2</strong>
                    </div><!-- /.property-box-meta-item -->

                    <div class="property-box-meta-item">
                        <span>Beds</span>
                        <strong>4</strong>
                    </div><!-- /.property-box-meta-item -->

                    <div class="property-box-meta-item">
                        <span>Garages</span>
                        <strong>1</strong>
                    </div><!-- /.property-box-meta-item -->
                </div><!-- /.property-box-meta -->
            </div><!-- /.property-box-content -->

           <div class="property-box-bottom">
                <div class="property-box-price">
                    Samra Lakes
                </div><!-- /.property-box-price -->

                <a href="properties-grid.html##" class="property-box-view">
                    178 Prairie Ridge Drive<br />St. Augustine FL 32092
                </a><!-- /.property-box-view -->
            </div><!-- /.property-box-bottom -->
            
            <div class="property-box-bottom">
                <div class="property-box-price">
                    $ 17,000
                </div><!-- /.property-box-price -->

                <a href="properties-grid.html##" class="property-box-view">
                    View Detail
                </a><!-- /.property-box-view -->
            </div><!-- /.property-box-bottom -->
        </div><!-- /.property-box -->
    </div>
	   </cfloop>
</cfoutput>
	</div>