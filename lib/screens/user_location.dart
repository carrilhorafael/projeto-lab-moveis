import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class UserMap extends StatefulWidget {
  UserMap(this.sourceUser, this.destinationUser);
  final LatLng sourceUser;
  final LatLng destinationUser;

  @override
  State<UserMap> createState() => UserMapState();
}

class UserMapState extends State<UserMap> {
  Completer<GoogleMapController> _controller = Completer();

  // pathing
  PolylinePoints _polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  //

  @override
  void initState() {
    // criar polyline
    addPolyLine() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id, color: Colors.red, points: _polylineCoordinates);
      _polylines[id] = polyline;
      setState(() {});
    }

    // query pro google
    void makeLines() async {
      await _polylinePoints
          .getRouteBetweenCoordinates(
        'AIzaSyDcETZGZ5nMWqD8rD-U3rTTlUPfqz-eEq8',
        PointLatLng(widget.sourceUser.latitude,
            widget.sourceUser.longitude), //Starting LATLANG
        PointLatLng(widget.destinationUser.latitude,
            widget.destinationUser.longitude), //End LATLANG
        travelMode: TravelMode.driving,
      )
          .then((value) {
        value.points.forEach((PointLatLng point) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }).then((value) {
        addPolyLine();
      });
    }

    makeLines();
    ///////////////
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialPos = CameraPosition(
      target: widget.sourceUser,
      zoom:
          14.4746, // deveria usar uma conta pra saber qual zoom usar (dependente das distancia dos dois pontos), mas é mais detalhe que outra coisa
    );

    final List<Marker> markers = <Marker>[
      Marker(
          markerId: MarkerId('SomeId'), // irrelevante
          position: widget.sourceUser,
          infoWindow: InfoWindow(title: 'Sua localização')),
      Marker(
          markerId: MarkerId('SomeId'),
          position: widget.destinationUser,
          infoWindow: InfoWindow(title: 'Local do usuário em conversa'))
    ];

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPos,
        markers: Set<Marker>.of(markers),
        polylines: Set<Polyline>.of(_polylines.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
