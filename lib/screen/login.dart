import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/components/alert.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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
                color: HexColor('#ED4848'),
              ),
            ),
          ),
        ),
        backgroundColor: HexColor('#2B2D42'),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
            padding:const EdgeInsets.all(15.0),
            child: Text(
              'Log in',
              style: GoogleFonts.inter(
                textStyle:const TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: _user,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: _pass,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 330,
              height: 70,
              child: ElevatedButton(
                onPressed: ()  {
                  // if (_formKey.currentState!.validate()) {
                  //   try {
                  //     UserCredential userCredential =
                  //         await AuthService().signInWithFirebase(_user.text, _pass.text);
                  //     if (userCredential.user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Alerts()),
                        );
                  //       developer.log('Login successful', name: 'my.app.category');
                  //     } else {
                  //       developer.log('User is not signed in');
                  //     }
                  //   } on FirebaseAuthException catch (e) {
                  //     if (e.code == 'user-not-found') {
                  //       developer.log('No user found for that email.');
                  //     } else if (e.code == 'wrong-password') {
                  //       developer.log('Wrong password provided for that user.');
                  //     }
                  //   }
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#ED4848'),
                  elevation: 10,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(fontSize: 23),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthService {
  Future<UserCredential> signInWithFirebase(String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}