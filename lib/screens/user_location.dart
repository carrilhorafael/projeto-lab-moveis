import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  MapSample(this.sourceUser, this.destinationUser);
  final LatLng sourceUser;
  final LatLng destinationUser;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {

    final CameraPosition initialPos = CameraPosition(
      target: widget.sourceUser,
      zoom: 14.4746,
    );

    final List<Marker> markers = <Marker>[
      Marker(
        markerId: MarkerId('SomeId'),
        position: widget.sourceUser,
        infoWindow: InfoWindow(
          title: 'The title of the marker'
        )
      ),
      Marker(
        markerId: MarkerId('SomeId'),
        position: widget.destinationUser,
        infoWindow: InfoWindow(
          title: 'The title of the marker'
        )
      )
    ];

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPos,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

      ),
    );
  }
}