import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      body: Loginform(),
    );
  }
}

class Loginform extends StatefulWidget {
  Loginform({Key? key}) : super(key: key);

  @override
  _loginfromstate createState() => _loginfromstate();
}

class _loginfromstate extends State<Loginform> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
       key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Log in',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _hasFocus = hasFocus;
              });
            },
            child: Container(
              child: TextFormField(
                controller: _user,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: _pass,
            obscureText: true,
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
              onPressed: () {
                getCredentials();
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

  Map<String, String> getCredentials() {
    Map<String, String> credentials = {
      'username': _user.text,
      'password': _pass.text,
    };

    return credentials;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
