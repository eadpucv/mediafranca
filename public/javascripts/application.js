// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function destacar(id,size)
{
	var i=1;
	while (i<size)
	{	
		var divDest = "c_"+i;
    	document.getElementById(divDest).style.backgroundColor='#FFFFFF';     	    	
    	i=i+1;  	
	}
		
		var divDest = "c_"+id;	
		document.getElementById(divDest).style.backgroundColor='#FFFCCC';
}

function gmap_update_position(){
	alert("lala");
  }

function gmap_update_zoom(){
    zoom = document.getElementById('coffee_house_zoom');
    zoom.value = ""+ map.getZoom();
  }

function showMap(div){

	var cloudmade = new CM.Tiles.CloudMade.Web({key: 'f227f541a93b46a884a3c73a516a9895', styleId:19780});
	var map = new CM.Map(div, cloudmade);
	var icon = new CM.Icon();
		icon.image  = "../images/pin2.png";
		icon.shadow = "../images/pinshadow.png";
		icon.shadowSize =new CM.Size(36,27);
		icon.iconSize = new CM.Size(30, 30);
		icon.iconAnchor = new CM.Point(16, 32);
		
	map.setCenter(new CM.LatLng(-33.414978, -71.37222), 4);
	map.addControl(new CM.LargeMapControl());
	map.addControl(new CM.ScaleControl());	
	
	var markers = [];
	for (var i = 0; i < samplePoints.length; i++) {
	markers.push(new CM.Marker(new CM.LatLng(samplePoints[i][0], samplePoints[i][1]), {icon: icon}));
	}
	
	var clusterer = new CM.MarkerClusterer(map, {clusterRadius: 70});
	clusterer.addMarkers(markers);
}

function blanc(div,txt) {
	if (txt == null)
		document.getElementById(div).value="";
	else
		if (document.getElementById(div).value == "")
			document.getElementById(div).value=txt;
		
	
}
function deleteTag(id)
{
	var tag 	= "topic_input_"+id
	var input 	= "topic_li_"+id
	$(tag).hide();
	$(input).hide();


}

/*
function setupCalendars() {
        // Popup Calendar
        Calendar.setup(
          {
            dateField: 'popupDateField',
            triggerElement: 'popupDateField'
          }
        )
      }

      Event.observe(window, 'load', function() { setupCalendars() })
*/

