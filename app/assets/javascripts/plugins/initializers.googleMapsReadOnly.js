(function($) {
  var mapInitializers = [];
  var defaultZoom = 15;
  var defaultMapCenter = { lat: -34.913283, lng: -57.951501 };
  var unintentialSubmitBlocker = 'onkeypress="if (event.keyCode === 13) { event.preventDefault(); return false; }"';
  var infoWindowContentTemplate = '<div class="input-group">' +
                                    '<input type="text" class="form-control marker-name"' + unintentialSubmitBlocker + ' readonly>'
                                    + '</div>';
  var mapContainerTemplate = '<div class="map-container"><div class="map-canvas"></div><div class="map-markers-list"><i class="glyphicon glyphicon-map-marker map-markers-list-label"></i></div></div>';
  var markerListItemTemplate = '<div class="map-marker-list-item">' +
                                 '<input type="hidden" class="marker-data">' +
                                 '<div class="title" data-focus></div>' +
                               '</div>';


  function condition() {
    return $('[data-google-maps-readonly]').length > 0;
  }

  function updateMarkerInformation(marker, title) {
    if (typeof title !== 'undefined') {
      marker.setTitle(title);
    }

    marker.get('item')
      .find('.title')
        .html(marker.getTitle() || '&mdash;')
      .end()
      .find('.marker-data')
        .val(JSON.stringify({title: marker.getTitle(), position: { lat: marker.getPosition().lat(), lng: marker.getPosition().lng() } }))
      .end();
  }

  function createInfoWindow(map, marker, title, remainClosed) {
    var infoWindowContent = $(infoWindowContentTemplate);
    if (title) {
      infoWindowContent.find('.marker-name').val(title);
    }
    // Register DOM event listeners
    infoWindowContent.on('keyup', '.marker-name', function(e) {
      updateMarkerInformation(marker, $(this).val());
    });
    infoWindowContent.find('[data-remove]').data('marker', marker);
    // Create, store a ref to and open the InfoWindow
    var infoWindow = new google.maps.InfoWindow({ content: infoWindowContent.get(0), maxWidth: 240 });
    marker.set('infoWindow', infoWindow);
    if (!remainClosed) {
      infoWindow.open(map, marker);
    }
    return infoWindow;
  }

  function createMarkerListItem(marker) {
    var markerListItem = $(markerListItemTemplate);
    markerListItem.find('.marker-data').attr('name', marker.getMap().get('inputName'));
    markerListItem.find('[data-remove], [data-focus]').data('marker', marker);
    markerListItem.appendTo(marker.getMap().get('markers'));
    marker.set('item', markerListItem);
    updateMarkerInformation(marker);
    return markerListItem;
  }

  function addMarker(map, position, title, doNotOpenInfoWindow) {
    var marker = new google.maps.Marker({
      map: map,
      position: position,
      title: title,
      animation: google.maps.Animation.DROP,
    });
    createMarkerListItem(marker);
    createInfoWindow(map, marker, title, doNotOpenInfoWindow);
    marker.addListener('click', handleMarkerClick);
    return marker;
  }

  function handleMarkerClick() {
    this.get('infoWindow').open(this.getMap(), this);
  }

  function handleMapClick(e) {
    addMarker(this, e.latLng);
  }

  function handleClickFocusMarker() {
    var marker = $(this).data('marker');
    var map = marker.getMap();
    map.setCenter(marker.getPosition());
    map.panTo(marker.getPosition());
    google.maps.event.trigger(marker, 'click');
  }

  function loadMarkersFromInput(input, map) {
    var markers = [];
    try {
      var bounds = map.get('bounds') || new google.maps.LatLngBounds();
      markers = JSON.parse(input.val());
      markers.forEach(function(marker) {
        var m = addMarker(map, marker.position, marker.title, true);
        bounds.extend(m.getPosition());
      });
      if (markers.length > 0) {
        map.fitBounds(bounds);
        map.set('bounds', bounds);
      }
    } catch(e) {
      if (window.console && console.error) {
        console.error(e);
      }
    }
  }

  function createMapInitializer(input, container) {
    var canvas = container.find('.map-canvas');
    var markersList = container.find('.map-markers-list');
    return {
      init: function() {
        var map = new google.maps.Map(canvas.get(0), {
          center: defaultMapCenter,
          zoom: defaultZoom,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        map.set('markers', markersList);
        map.set('inputName', input.attr('name') + '[]');
       // Add markers specified by the input
        loadMarkersFromInput(input, map);
        // Focus on the marker when click the item
        markersList.on('click', '[data-focus]', handleClickFocusMarker);
        // Force the original input to be empty so that we always send something in the markers field
        input.attr('name', map.get('inputName')).val('');
      },
      target: input,
      container: container
    };
  }

  function initializer() {
    var apiKey;
    $('[data-google-maps-readonly]').each(function() {
      var $this = $(this);
      apiKey = apiKey || $this.data('google-maps-readonly');
      var $container = $(mapContainerTemplate).insertAfter($this);
        mapInitializers.push(createMapInitializer($this, $container));
    });

    // Register global initializer for Google Maps
    window.initializeGoogleMaps = function() {
      $.each(mapInitializers, function(i, initializer) {
        initializer.init.call(initializer.target);
      });
    };

    // Load Google Maps API client script only once
    $(document.body).append('<script async defer src="//maps.googleapis.com/maps/api/js?signed_in=true&libraries=places&key=' + apiKey + '&callback=initializeGoogleMaps">');
  }

  Initializers.register('google-maps-readonly', initializer, condition);
}(jQuery));
