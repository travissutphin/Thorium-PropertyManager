<cfoutput>	
<h4>
<cfif isDefined('records_Rentals.recordcount')>#records_Rentals.recordcount# Results </cfif>
<cfif isDefined('order_random')>Showing all Rentals</cfif>
</h4>	

<cfinvoke 
	component="#request.cfc#.rentals"
	method="display_search_breadcrumbs">
</cfinvoke>

<script src="http://maps.google.com/maps/api/js?key=AIzaSyA9Uf5xsgRhoylWuN6mtze9XTcVTNaPELI" type="text/javascript"></script>

<div id="map_canvas" style="height: 400px; width: 100%;"></div>

<cfset locations = ''>
<cfset n = 1>
<cfloop query="records_Rentals">
	<cfset locations = #locations# & "['#records_Rentals.ren_address#', #records_Rentals.ren_latitude#, #records_Rentals.ren_longitude#, #n#], ">
	<cfset n = #n#+1>
</cfloop>   

<!--- remove trailing comma --->
<cfset locations = REReplace(locations, ", $", "")>

<script type="text/javascript">
    var locations = [
      #locations#
    ];

    var map = new google.maps.Map(document.getElementById('map_canvas'), {
      zoom: 10,
      center: new google.maps.LatLng(29.943739, -81.489555),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;

    for (i = 0; i < locations.length; i++) { 
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }
      })(marker, i));
    }
  </script>


</cfoutput>