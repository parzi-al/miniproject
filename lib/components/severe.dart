import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/ambsvr.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Severe extends StatefulWidget {
  Severe({Key? key}) : super(key: key);

  @override
  State<Severe> createState() => _SevereState();
  static String? get currentAddress => _SevereState.currentAddress;
  static Position? get currentPosition => _SevereState.currentPosition;
}

@override
class _SevereState extends State<Severe> {
  static String? currentAddress;
  static Position? currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
      }
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => currentPosition = position);
      _getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

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



  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
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
                  print('LAT: ${currentPosition?.latitude ?? ""}');
                  print('LNG: ${currentPosition?.longitude ?? ""}');
                  print('ADDRESS: ${currentAddress ?? ""}');
                  print(svr[currentIndex]);
                  print(user?.uid);
                  CollectionReference collref =
                      FirebaseFirestore.instance.collection('callforhelp');
                  collref.add({
                    'severity': svr[currentIndex],
                    'uid': user?.uid,
                    'Latitude': currentPosition?.latitude,
                    'Longitude': currentPosition?.longitude,
                  });

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content:
                            const Text('Are you sure you want to continue?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              child: const Text('Continue'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Ambsvr()),
                                );
                              }),
                        ],
                      );
                    },
                  );
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



