import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Severe extends StatefulWidget {
  Severe({Key? key}) : super(key: key);

  @override
  State<Severe> createState() => _SevereState();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class _SevereState extends State<Severe> {
  List<int> svr = List.generate(10, (index) => index + 1);
  int currentIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  List<Color> colors = const [
    Color(0xFF3DA351),
    Color(0xFF50984E),
    Color(0xFF618F4B),
    Color(0xFF738548),
    Color(0xFF857A45),
    Color(0xFF996F42),
    Color(0xFFAA663F),
    Color(0xFFBB5C3C),
    Color(0xFFCD5239),
    Color.fromARGB(255, 218, 70, 53),
  ];
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();

  void _addToFirestore() async {
    String data = _controller.text;
    await _db.collection('callforhelp').add({
      'message': svr[currentIndex],
      'uid': user?.uid,
    });
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  void _storeData() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('callforhelp').push().set({
      // Update the code
      'message': svr[currentIndex],
      'uid': user?.uid,
    }).then((_) {
      print('Data stored successfully.');
    }).catchError((error) {
      print('Failed to store data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[currentIndex % colors.length],
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
        backgroundColor: colors[currentIndex % colors.length],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 315,
              child: Text(
                'Rate the severity of the patient',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: colors[currentIndex % colors.length],
                    minimumSize: const Size(70, 170),
                  ),
                  onPressed: () {
                    _storeData();
                    setState(() {
                      currentIndex =
                          (currentIndex - 1 + svr.length) % svr.length;
                    });
                  },
                  child: const Icon(Icons.navigate_before,
                      size: 84.0, color: Colors.white),
                ),
                Center(
                  child: Text(
                    svr[currentIndex].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 180,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(70, 170),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex + 1) % svr.length;
                    });
                  },
                  child: const Icon(Icons.navigate_next,
                      size: 84.0, color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print(svr[currentIndex]);
                  print(user?.uid);
                  //
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  backgroundColor: HexColor('#2B2D42'),
                  foregroundColor: Colors.white,
                  elevation: 10,
                  minimumSize: const Size(358, 73),
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    );
  }
}
/*
void _storeUserData() {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  List<int> svr = List.generate(10, (index) => index + 1);
  int currentIndex = 0;

  databaseReference.child('callforhelp').push().set({
    'severity': svr[currentIndex],
    'uid': FirebaseAuth.instance.currentUser!.uid,
  }).then((_) {
    print('Data stored successfully.');
  }).catchError((error) {
    print('Failed to store data: $error');
  });
}
*/



