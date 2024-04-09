import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/components/alert.dart';
class Amb extends StatefulWidget {
  const Amb({Key? key}) : super(key: key);
  
  @override
  State<Amb> createState() => _AmbState();
}

class _AmbState extends State<Amb> {
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
        body: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        AlertScreen(),
                    transitionDuration: Duration(seconds: 1),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
            },
            child: Container(
              width: 313.0, // diameter 50
              height: 313.0, // diameter 50
              decoration: BoxDecoration(
                color: HexColor("#EDF6FF"),
                shape: BoxShape.circle,
                border: Border.all(
                  color: HexColor("#8D99AE"),
                  width: 5.0,
                ),
              ),
              child: Center(
                child: Text(
                  "No New Alerts",
                  style: TextStyle(
                    color: HexColor("#2B2D42"),
                    fontSize: 40.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        )
        );
  }
}

