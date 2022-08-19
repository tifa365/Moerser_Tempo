
var map = L.map('map').setView([51.4515, 6.6285], 12);

//Der map einen Tile-Layer hinzufügen, damit man auch eine Karte sieht
L.tileLayer( 'http://tiles.codefor.de/static/bbs/germany/{z}/{x}/{y}.png', {
	attribution: 'Map data &copy; <a href="http://openstreetmap.org/">OpenStreetMap</a> contributors, Tiles: <a href="http://codefor.de">CfG-Map Server</a>'}).addTo( map );

function onEachFeature(feature, layer) {
	//
	if (feature.properties){
		var popup = '';
		if(feature.properties.name) { popup = popup + '<h1>' + feature.properties.name + '</h1>';}
		if(feature.properties.speed) { popup = popup + '<img src="img/' + feature.properties.speed + '.svg" width="40px" alt="Erlaubte Geschwindigkeit: '+ feature.properties.speed + '">';}
		if(feature.properties.pic) { popup = popup + '<br><img src="img/' + feature.properties.pic + '" width="720px">';}
		if(feature.properties.date) { popup = popup + '<br>Start der letzten Messung ' + feature.properties.date + '. <a href="img/' + feature.properties.pic + '" target="_new">Grafik in neuem Tab öffnen</a>' ;}
		layer.bindPopup(popup, {maxWidth: 1000});
		layer.on('click', onClick);
	}
}

function onClick(e) {map.setZoomAround( this.getLatLng(), 14 );}
//marker.on('click', function(e) {
////    alert(e.latlng);
//    map.setZoomAround( e.latlng, 14 )
//});

//Test geojson Feature
var ackerstraße = {
	"type": "Feature",
	"properties":
	{
		"name": "Ackerstrasse 40",
		"speed": 30,
		"date": 05112014
	},
	"geometry": {
		"type": "Point",
		"coordinates": [6.62, 51.459]
	}
};


//Ein neues geojson Layer erstellen und der map hinzufügen
//var myLayer = L.geoJson().addTo(map);
//Dem Layer ein neues Feature hinzufügen!
//myLayer.addData(geojsonFeature);
//myLayer.addData(ackerstraße);

//Alternativ ein einem:
//L.geoJson(geojsonFeature).addTo(map);
var layer1 = L.geoJson(messstellen, {
			onEachFeature: onEachFeature
		}).addTo(map);

//Mehrere Marker usw zu einer Layer Group zusammenfassen
//var cities = L.layerGroup([marker, circle]);
//Layer oder LayerGroups, die nachher als Overlay zur Auswahl stehen sollen
//var overlayMaps = {
//    "Cities": cities,
//    "geoJSON": myLayer
//};
//erstelle ein Layer Control, mit verschiedenen Base Layern und Overlays zur Auswahl :)
//L.control.layers(baseMaps, overlayMaps).addTo(map);
//L.control.layers(null, overlayMaps).addTo(map);
