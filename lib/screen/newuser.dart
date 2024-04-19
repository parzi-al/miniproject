import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Newuser extends StatefulWidget {
   Newuser({Key? key}) : super(key: key);
  @override
  State<Newuser> createState() => _NewuserState();
}

class _NewuserState extends State<Newuser> {

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<UserCredential?> signUp(String email, String password, String username, String phoneNumber) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update user profile
    await userCredential.user!.updateProfile(displayName: username);

    // Store additional information in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'username': username,
      'phoneNumber': phoneNumber,
    });

    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return null;
  }
}
  TextStyle buildTextStyle(
      {double fontSize = 30,
      FontWeight fontWeight = FontWeight.normal,
      color = Colors.white}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  late Widget currentBody;
  @override
  void initState() {
    super.initState();
    currentBody = buildInitialBody();
  }

  Widget buildInitialBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "New User",
              style: buildTextStyle(
                  fontSize: 42.92,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email ID',
                labelStyle: buildTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _user,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: buildTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _pass,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Password',
                labelStyle: buildTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _pass,
              decoration: InputDecoration(
                labelText: 'Confirfm Password',
                labelStyle: buildTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _phno,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: buildTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
  onPressed: () async {
    UserCredential? userCredential = await signUp(_email.text, _pass.text, _user.text, _phno.text);
    if (userCredential == null) {
      // Handle sign up failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Handle sign up success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mainscreen()), // Navigate to HomePage after successful sign up
      );
    }
  },
 
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor('#EF233C')),
              ),
              child: Text('Continue',
                  style: buildTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phno = TextEditingController();
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#2B2D42'),
      appBar: AppBar(
        centerTitle: true,
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
      body: currentBody,
    );
  }
}

class NextBody extends StatelessWidget {
  NextBody({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: Text(
              "Register using Google Account",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              backgroundColor: HexColor('#8D99AE'),
              foregroundColor: Colors.white,
              elevation: 10,
              minimumSize: Size( 358, 73),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Set this
              children: [
                Image.asset('images/google.png', height: 20), // Add this
                SizedBox(width: 10), // Add this for some spacing
                Text(
                  'verify with Google Account',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 20.11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
