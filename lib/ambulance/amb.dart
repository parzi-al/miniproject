import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/components/alert.dart';
import 'package:flutter_application_1/ambulance/ambsvr.dart';

class Amb extends StatefulWidget {
  const Amb({Key? key}) : super(key: key);

  @override
  State<Amb> createState() => _AmbState();
}

class _AmbState extends State<Amb> {
  bool condition = true;
  @override
  Widget build(BuildContext context) {
    return condition
        ? const AmbNew()
        : Scaffold(
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
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class AmbNew extends StatefulWidget {
  const AmbNew({Key? key}) : super(key: key);

  @override
  State<AmbNew> createState() => _AmbNewState();
}

class _AmbNewState extends State<AmbNew> {
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
                color: HexColor("#EF233C"),
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
              MaterialPageRoute(builder: (context) => Ambsvr()),
            );
          },
          child: Container(
            width: 313.0,
            height: 313.0,
            decoration: BoxDecoration(
              color: HexColor("#EF233C"),
              shape: BoxShape.circle,
              border: Border.all(
                color: HexColor("#8D99AE"),
                width: 5.0,
              ),
            ),
            child: Center(
              child: Text(
                "NEW ALERT!",
                style: TextStyle(
                  color: HexColor("#FFFFFF"),
                  fontSize: 40.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
