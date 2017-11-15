<cfif isDefined('url.alias')>

<cfelse>
	<cfset #url.alias# = "home">
</cfif>
<cfinclude template="controller.cfm">
<cfoutput>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

    <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Roboto:400,300,500,700&amp;subset=latin,latin-ext">
    <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Montserrat:400,700">
    <link rel="stylesheet" type="text/css" href="assets/libraries/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libraries/bootstrap-select/dist/css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libraries/bootstrap-fileinput/css/fileinput.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libraries/nvd3/nv.d3.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libraries/OwlCarousel/owl-carousel/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="assets/css/realsite.css">
    <link rel="stylesheet" type="text/css" href="assets/css/my_css.css">
 
    <title></title>
</head>

<body>

<div class="page-wrapper">
                <div class="header header-standard header-call-to-action-wrapper">
    <div class="relative">
        <div class="blur header-background overflow-hidden"></div>

        <div class="header-background-inner">

            <div class="container">
                <div class="header-inner">
                    <div class="header-main">
                        <div class="header-title">
							<a href="#REQUEST.siteURL#">
                                <img src="assets/img/logoXX.png" alt="">

                                <span></span>
                            </a>
                        </div><!-- /.header-title -->

                        <div class="header-navigation">
                            
                            <div class="nav-main-wrapper">
    
							
								<div class="nav-main-title visible-xs">
									<a href="index.html">
										<img src="assets/img/logo-blueXX.png" alt="">

										Realsite
									</a>
								</div><!-- /.nav-main-title -->

								<div class="nav-main-inner">
									<nav>
										<ul id="nav-main" class="nav nav-pills">
											
											<cfif isDefined('SESSION.Auth.role_fk') and #SESSION.Auth.role_fk# eq '2'>
												<li class="has-children active ">
													<a href="My-Profile">My Profile</a>
												</li>
												<li>
													<a href="Logout">Log Out</a>
												</li>
											<cfelse>
												<li class="important">
													<a href="Login">Login</a>
												</li>
											</cfif>

											<li class="has-children">
												<a href="Road-Map">Road Map</a>
											</li>
																						
										</ul><!-- /.nav -->
									</nav>
								</div><!-- /.nav-main-inner -->
</div><!-- /.nav-main-wrapper -->

<button type="button" class="navbar-toggle">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
</button>
                        
                        </div><!-- /.header-navigation -->
                    </div><!-- /.header-main -->

                   
                    
                </div><!-- /.header-inner -->
            </div><!-- /.container -->
        </div><!-- /.header-background-inner-->
    </div><!-- /.relative -->
</div><!-- /.header-->

<!--- CONTENT AREA STARTS HERE --->
<!-------------------------------->
<div class="main">
 
	<div class="container">
		
		<div class="row">
        
  	<cfif #url.alias# eq "homesss">

		<!--- CONTENT FULL PAGE --->
    	<cfinclude template="templates/template_content_index.cfm">

	<cfelse>
    
		<cfif #data_Page.p_layout_fk# eq '1'>

			<!--- CONTENT FULL PAGE --->
			<cfinclude template="templates/template_content_full.cfm">

		<cfelseif #data_Page.p_layout_fk# eq '2'>

			<!--- CONTENT ON THE LEFT --->
			<cfinclude template="templates/template_content_left.cfm">

		<cfelseif #data_Page.p_layout_fk# eq '3'>

			<!--- CONTENT ON THE RIGHT --->
			<cfinclude template="templates/template_content_right.cfm">

		</cfif>
    
	</cfif>
              
        </div><!-- /.row -->
        
	</div><!-- /.container -->

</div><!-- /.main -->

<!--- CONTENT AREA ENDS HERE --->
<!-------------------------------->


<!--- FOOTER AREA STARTS HERE --->
<!-------------------------------->
<div id="footer" class="footer">
    <div class="footer-top">
        <div class="container">
            <div class="footer-top-inner">
                <nav>
                    <ul class="nav nav-pills">
                        <li><a href="headers-call-to-action.html##">Home</a></li>
                        <li><a href="headers-call-to-action.html##">Properties</a></li>
                        <li><a href="headers-call-to-action.html##">Agencies</a></li>
                        <li><a href="headers-call-to-action.html##">Agents</a></li>
                        <li><a href="headers-call-to-action.html##">Pricing</a></li>
                        <li><a href="headers-call-to-action.html##">Blog</a></li>
                        <li><a href="headers-call-to-action.html##">Contact</a></li>
                    </ul>
                </nav>
            </div><!-- /.footer-top-inner -->
        </div><!-- /.container -->
    </div><!-- /.footer-top -->

    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-inner">
                <div class="footer-bottom-left">
                    bottom left
                </div><!-- /.footer-bottom-left -->

                <div class="footer-bottom-right">
                    bottom right
                </div><!-- /.footer-bottom-right -->
            </div><!-- /.footer-bottom-inner -->
        </div><!-- /.container -->
    </div><!-- /.footer-bottom -->
</div><!-- /.footer -->

<!--- FOOTER AREA ENDS HERE --->
<!-------------------------------->

      
</div><!-- /.page-wrapper-->


<script type="text/javascript" src="assets/js/jquery.js"></script>
<script type="text/javascript" src="assets/libraries/jquery-transit/jquery.transit.js"></script>

<script type="text/javascript" src="assets/libraries/bootstrap/assets/javascripts/bootstrap/dropdown.js"></script>
<script type="text/javascript" src="assets/libraries/bootstrap/assets/javascripts/bootstrap/collapse.js"></script>
<script type="text/javascript" src="assets/libraries/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="assets/libraries/bootstrap-fileinput/js/fileinput.min.js"></script>

<script type="text/javascript" src="assets/libraries/autosize/jquery.autosize.js"></script>
<script type="text/javascript" src="assets/libraries/isotope/dist/isotope.pkgd.min.js"></script>
<script type="text/javascript" src="assets/libraries/OwlCarousel/owl-carousel/owl.carousel.min.js"></script>
<script type="text/javascript" src="assets/libraries/jquery.scrollTo/jquery.scrollTo.min.js"></script>

<!---
<script src="http://maps.googleapis.com/maps/api/js?libraries=weather,geometry,visualization,places,drawing&amp;sensor=false" type="text/javascript"></script>
<script type="text/javascript" src="assets/libraries/jquery-google-map/infobox.js"></script>
<script type="text/javascript" src="assets/libraries/jquery-google-map/markerclusterer.js"></script>
<script type="text/javascript" src="assets/libraries/jquery-google-map/jquery-google-map.js"></script>
--->

<script type="text/javascript" src="assets/libraries/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="assets/libraries/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="assets/libraries/nvd3/nv.d3.min.js"></script>

<script type="text/javascript" src="assets/js/realsite.js"></script>
<script type="text/javascript" src="assets/js/charts.js"></script>
<script type="text/javascript" src="assets/js/map.js"></script>

<cfif isDefined('script_text_counter')>
	<script>
		function textCounter(field,field2,maxlimit)
		{
		 var countfield = document.getElementById(field2);
		 if ( field.value.length > maxlimit ) {
		  field.value = field.value.substring( 0, maxlimit );
		  return false;
		 } else {
		  countfield.value = maxlimit - field.value.length;
		 }
		}
	</script>
</cfif>

</body>
</html>
	  </cfoutput>