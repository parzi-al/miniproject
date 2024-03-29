import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/screen/create.dart';

class Mainscreen extends StatefulWidget {
  Mainscreen({Key? key}) : super(key: key);

  @override
  Mainscreenstate createState() => Mainscreenstate();
}

class Mainscreenstate extends State<Mainscreen> {
  TextStyle buildTextStyle({double fontSize = 30, FontWeight fontWeight = FontWeight.normal,  color = Colors.white}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onPressed, required  color}) {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#2B2D42'),
      appBar: AppBar(
        title: Center(
          child: Text(
            'HOSPIFY',
            style: buildTextStyle(fontSize: 42.92, fontWeight: FontWeight.w800, color: HexColor('#ED4848')),
          ),
        ),
        backgroundColor: HexColor('#2B2D42'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('images/Ambulance.png'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'WELCOME TO',
                style: buildTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'HOSPIFY',
                style: buildTextStyle(fontSize: 75, fontWeight: FontWeight.w800, color: HexColor('#ED4848')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: buildButton(
                      text: 'Login',
                      
                     onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Login()),
                        );
                      },
                      color: HexColor('#ED4848'),
                    ),
                  ),
                  buildButton(
                    text: 'Create Account',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Createacc()),
                      );
                    },
                    color: HexColor('#ED4848'),
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
