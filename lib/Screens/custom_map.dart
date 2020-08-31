import 'dart:async';
import 'package:client_mazdoor/Gvariable.dart' as global;
import 'package:client_mazdoor/Services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  // For getting device Location
  Geolocator geolocator;
  Position positions;
  StreamSubscription _positioStream;
  var random = Random();
  SharedPreferences sharedPreferences;

  // Google Map
  GoogleMapController mapController;
  //Placemark place;
  static LatLng initialPosition;
  LatLng lastPosition = initialPosition;
  String presentAddress;
  List<Placemark> placemark;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Set<Marker> _markers = Set();

  // method get position
  void _getlocation() {
    geolocator = Geolocator()..forceAndroidLocationManager;
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positioStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      placemark = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      setState(() {
        positions = position;
        initialPosition = LatLng(positions.latitude, positions.longitude);

        presentAddress = placemark[0].name.toString() +
            ", " +
            placemark[0].locality.toString() +
            ", Postal Code:" +
            placemark[0].postalCode.toString();
        global.userAddress = presentAddress.toString();
        global.userLatitude = position.latitude;
        global.userLongitude = position.longitude;
        //UserServices().userLocationStore();
      });
    });
    //UserServices().userLocationStore();
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      lastPosition = position.target;
    });
  }

  // Add Marker

  populateClient() {
    Firestore.instance
        .collection("Labors_Info")
        //.where("laborType", isEqualTo: "Construction")
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          initsMarker(docs.documents[i].data, docs.documents[i].documentID);
        }
      } else {
        print("Docments have no data hhahahahaha");
      }
    });
    print("BBBBBBB");
  }

  // populateLabor() {
  //   return StreamBuilder(
  //       stream: Firestore.instance.collection("Users_Info").snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return Text(
  //             "Loading... Plese wait",
  //             style: TextStyle(fontSize: 20.0),
  //           );
  //         } else {
  //           for (int i = 0; i < snapshot.data.documents.length; i++) {
  //             DocumentSnapshot labors = snapshot.data.document[i];

  //             initsMarker(labors.data[i], labors.documentID[i]);
  //           }
  //         }
  //       });
  // }

  void initsMarker(request, requestId) {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    //Creating a new Marker
    final Marker marker = Marker(
        onTap: () async {
          sharedPreferences = await SharedPreferences.getInstance();
          String currentUserId = sharedPreferences.get("currentUserId");

          Firestore.instance
              .collection("Labor_Requests")
              .document(request["laborType"] + requestId)
              .setData({
            "laborId": requestId,
            "laborName": request["laborName"],
            "laborToken": request["laborToken"],
          }).whenComplete(() {
            Firestore.instance
                .collection("Users_Info")
                .document(currentUserId)
                .get()
                .then((DocumentSnapshot snapshot) {
              var labor = snapshot.data;

              Firestore.instance
                  .collection("Labor_Requests")
                  .document(request["laborType"] + requestId)
                  .collection("From_User")
                  .document(currentUserId)
                  .setData({
                "userName": labor["userName"],
                "userPhone": labor["userPhoneNumber"],
                "userToken": labor["userToken"],
              });
            });
          }).whenComplete(() => print("Request store"));
        },
        markerId: markerId,
        position: LatLng(request["laborLatitude"], request["laborLongitude"]),
        infoWindow: InfoWindow(
          title: request["laborType"].toString(),
          snippet: request["laborName"].toString(),
        ));
    _markers.add(marker);
  }

  // void initMarker(request, requestId) {
  //   var markerIdVal = requestId;
  //   final MarkerId markerId = MarkerId(markerIdVal);
  //   //Creating a new Marker
  //   final Marker marker = Marker(
  //       markerId: markerId,
  //       position: LatLng(request["laborLatitude"], request["laborLongitude"]),
  //       infoWindow: InfoWindow(
  //         title: request["laborType"].toString(),
  //         snippet: request["laborName"].toString(),
  //       ));
  //   setState(() {
  //     markers[markerId] = marker;
  //     print(markerId);
  //   });
  // }

  @override
  void initState() {
    _getlocation();
    //populateLabor();
    populateClient();
    super.initState();
  }

  @override
  void dispose() {
    _positioStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: initialPosition == null
                ? Center(
                    heightFactor: 100.0,
                    widthFactor: 100.0,
                    child: CircularProgressIndicator(
                      value: 50.0,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                : GoogleMap(
                    onMapCreated: onCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(positions.latitude, positions.longitude),
                      zoom: 16.0,
                    ),
                    onCameraMove: onCameraMove,
                    compassEnabled: true,
                    myLocationEnabled: true,
                    //markers: Set<Marker>.of(markers.values),
                    markers: _markers,
                  ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: () => UserServices().userLocationStore(),
                  child: Text("Proceed")))
        ],
      ),
    );
  }
}
