import 'package:flutter/material.dart';
import 'package:flutter_application_1/ambulance/amb.dart';
import 'package:flutter_application_1/screen/newuser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Createacc extends StatefulWidget {
  const Createacc({Key? key}) : super(key: key);

  @override
  Loginstate createState() => Loginstate();
}

class Loginstate extends State<Createacc> {
  

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: HexColor('#ED4848'),
    foregroundColor: Colors.white,
  );

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
                fontSize: 42.92,
                fontWeight: FontWeight.w800,
                color: HexColor('#ED4848'),
              ),
            ),
          ),
        ),
        backgroundColor: HexColor('#2B2D42'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Create Account', style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize:44,
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  buildButton('Register as new user', isNewUser: true),
                  buildButton('Register as Ambulance Driver',),
                  buildButton('Register as Alert receiver'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget buildButton(String text, {bool isNewUser = false}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      width: 330,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          if (isNewUser){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Newuser()),
          );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Amb()),
            );
          }
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Amb()),
            );
        },
        style: buttonStyle,
        child: Text(text,style: TextStyle(fontSize: 23),),
      ),
    ),
  );
}
}