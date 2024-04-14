import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapping extends StatefulWidget {
  const Mapping({super.key});

  @override
  State<Mapping> createState() => _MappingState();
}

class _MappingState extends State<Mapping> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng Destination = LatLng(37.33429383, -122.06600055);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            body: const Center(
              child: GoogleMap(initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 14.4746,))
            ),
    );
  }
}