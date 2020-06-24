import 'dart:async';
import 'package:client_mazdoor/Gvariable.dart' as global;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  
  // For getting device Location
  Geolocator geolocator;
  Position positions;
  StreamSubscription _positioStream;

  // Google Map
  GoogleMapController mapController;
  Placemark place;
  static LatLng initialPosition;
  LatLng lastPosition = initialPosition;

  
  // method get position
  void _getlocation(){
    geolocator = Geolocator() ..forceAndroidLocationManager;
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positioStream = geolocator.getPositionStream(locationOptions).listen((Position position) { 
      setState(() {
        positions = position;
        initialPosition = LatLng(positions.latitude, positions.longitude);

        global.userLatitude = position.latitude.toString();
        global.userLongitude = position.longitude.toString();
      });
    });
  }

  void onCreated(GoogleMapController controller){
    setState(() {
      mapController = controller;
    });
  }

  void onCameraMove(CameraPosition position){
    setState(() {
      lastPosition = position.target;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getlocation();
    super.initState();
  }

  @override
  void dispose(){
    _positioStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: initialPosition == null? Center(
            heightFactor: 100.0,
            widthFactor: 100.0,
            child: CircularProgressIndicator(
              value: 50.0,
              backgroundColor: Theme.of(context).primaryColor,
              
            ),
          ): GoogleMap(
            onMapCreated: onCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(positions.latitude, positions.longitude),
              zoom: 12.0,
              ),
              onCameraMove: onCameraMove,
              compassEnabled: true,
              ),
        )
      ],
    );
  }
}