import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/components/severe.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ambsvr extends StatefulWidget {
  Ambsvr({Key? key}) : super(key: key);
  @override
  State<Ambsvr> createState() => _AmbsvrState();
}

class _AmbsvrState extends State<Ambsvr> {
  LatLng? destination1;

  Future<void> getLatLng() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('callforhelp')
        .doc('qkAvPecfZaR1ASGWJztI')
        .get();
    final latitude = snapshot.get('Latitude');
    final longitude = snapshot.get('Longitude');
    setState(() {
      destination1 = LatLng(latitude, longitude);
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(9.9902, 76.92358);

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      api, // Your Google Map Key
      PointLatLng(
          Severe.currentPosition!.latitude, Severe.currentPosition!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getLatLng();
  }

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
        initialCameraPosition: CameraPosition(
          target: LatLng(Severe.currentPosition!.latitude,
              Severe.currentPosition!.longitude),
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            position: LatLng(Severe.currentPosition!.latitude,
                Severe.currentPosition!.longitude),
          ),
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          if (destination1 != null)
            Marker(
              markerId: const MarkerId("destination1"),
              position: destination1!,
            ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: const Color(0xFF7B61FF),
            width: 6,
          ),
        },
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            getPolyPoints();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: HexColor('#2B2D42'),
            foregroundColor: Colors.white,
            elevation: 10,
            minimumSize: const Size(358, 73),
          ),
          child: const Text("Continue", style: TextStyle(fontSize: 20))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}