import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/severe.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
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
                    MaterialPageRoute(builder: (context) => AlertScreen()),
                  );
               
            },
            child: Container(
              width: 313.0, // diameter 50
              height: 313.0, // diameter 50
              decoration: BoxDecoration(
                color: HexColor("#EF233C"),
                shape: BoxShape.circle,
                border: Border.all(
                  color: HexColor("#8D99AE"),
                  width: 5.0,
                ),
              ),
              child: const Center(
                child: Text(
                  "Tap to Alert",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42.92,
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

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EF233C'),
      appBar: AppBar(
        backgroundColor: HexColor('#EF233C'),
        title: Center(
          child: Text(
            'HOSPIFY',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 43.92,
                fontWeight: FontWeight.w800,
                color: HexColor('#2B2D42'),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 376.0,
          height: 323.0,
          child: Center(
            child: Column(
              children: [
                const Text(
                  "ATTENTION!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42.92,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
              const SizedBox(height: 20), 
                Text(
                  'Make sure the alert is intended. False calls will be penalised.',
                  style: TextStyle(
                    color: HexColor("#EDF2F4"),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 344,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: HexColor("#EDF2F4"), 
                      backgroundColor: HexColor("#2B2D42"), // text color
                      side: BorderSide(width: 1, color: HexColor("#E5E5E5")), // border color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation:9,
                    ),
                    onPressed: () {
                    Navigator.pop(context);
                    },
                    child: const Text(
                      'Go back',
                      style:  TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 344,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: HexColor("#D90429"), // background color
                      backgroundColor: HexColor("#EDF2F4"), // text color
                      side: BorderSide(width: 1, color: HexColor("#E0E0E0")), // border color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                        elevation:9,
                    ),
                    onPressed: () {
                 Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        Severe(),
                    transitionDuration: Duration(seconds: 1),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
                    },
                    child:const Text(
                      'Continue alert!!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
