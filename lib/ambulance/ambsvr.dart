import 'dart:async';
import 'package:flutter_application_1/ambulance/nav.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ambsvr extends StatefulWidget {
  const Ambsvr({Key? key}) : super(key: key);

  @override
  State<Ambsvr> createState() => _AmbsvrState();
}

class _AmbsvrState extends State<Ambsvr> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(9.956497, -122.06600055);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#2B2D42'),
      appBar: AppBar(
        title: Center(
          child: Text(
            'HOSPIFY',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 43.92,
                fontWeight: FontWeight.w800,
                color: HexColor('#8D99AE'),
              ),
            ),
          ),
        ),
        backgroundColor: HexColor('#2B2D42'),
      ),
      body: GoogleMap(
      // initialCameraPosition: CameraPosition(
      //   target: LatLng(
      //    sourceLocation.latitude , sourceLocation.longitude),
      //   zoom: 13.5,
      // ),
      initialCameraPosition: CameraPosition(
        target: LatLng(
          LocationPage.currentPosition!.latitude , LocationPage.currentPosition!.longitude ),
        zoom: 13.5,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
               LocationPage.currentPosition!.latitude , LocationPage.currentPosition!.longitude),
        ),
        const Marker(
          markerId: MarkerId("source"),
          position: sourceLocation,
        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destination,
        ),
      },
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
      // polylines: {
      //   Polyline(
      //     polylineId: const PolylineId("route"),
      //     points: polylineCoordinates,
      //     color: const Color(0xFF7B61FF),
      //     width: 6,
      //   ),
      // },
    ),
    );
  }
}