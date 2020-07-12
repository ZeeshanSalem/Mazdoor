// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Reciever extends StatefulWidget {
//   @override
//   _RecieverState createState() => _RecieverState();
// }

// class _RecieverState extends State<Reciever> {
//   GoogleMapController _controller;
//   Position position1;
//   Widget _child;
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

//   @override
//   void initState() {
//     // TODO: implement initState

//     getCurrentLocation();
//     populateClients();

//     super.initState();
//   }

//   Future<bool> populateClients() async {
//     Firestore.instance.collection('Users_Info').getDocuments().then((docs) {
//       if (docs.documents.isNotEmpty) {
//         for (int i = 0; i < docs.documents.length; ++i) {
//           initMarker(docs.documents[i].data, docs.documents[i].documentID);
//         }
//       } else {
//         print(
//             "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//       }
//     });
//     print(
//         "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
//   }

//   void initMarker(lugar, lugaresid) {
//     var markerIdVal = lugaresid;
//     final MarkerId markerId = MarkerId(markerIdVal);

//     // creating a new MARKER
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(lugar['userLatitude'], lugar['userLongtitude']),
//       infoWindow: InfoWindow(
//           title: lugar['userPhoneNumber'], //snippet: lugar['LabCertified']
//           ),
//     );

//     setState(() {
//       // adding a new marker to map
//       markers[markerId] = marker;
//     });
//   }

//   void getCurrentLocation() async {
//     Position res = await Geolocator().getCurrentPosition();
//     setState(() {
//       position1 = res;
//       _child = mapWidget();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _child,
//     );
//   }

//   Widget mapWidget() {
//     return GoogleMap(
//       mapType: MapType.normal,
//       markers: Set<Marker>.of(markers.values),
//       initialCameraPosition: CameraPosition(
//         target: LatLng(position1.latitude, position1.longitude),
//         zoom: 17.0,
//       ),
//       onMapCreated: (GoogleMapController controller) {
//         _controller = controller;
//       },
//       myLocationEnabled: true,
      
//     );
//   }
// }