import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class  Mainscreen extends StatefulWidget {
  Mainscreen({Key? key}) : super(key: key);

  @override
  Mainscreenstate createState() => Mainscreenstate();
}

class Mainscreenstate extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    const String titles = '';

    return Scaffold(
      backgroundColor: HexColor('#2B2D42'),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/Ambulance.png'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'WELCOME TO',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'HOSPIFY',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 75,
                    color: HexColor('#ED4848'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#ED4848'),
                      ),
                      child: const Text('Create Account'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: HexColor('#ED4848'),
                      ),
                      child: const Text('login'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}