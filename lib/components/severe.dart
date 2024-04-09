import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Severe extends StatefulWidget {
  Severe({Key? key}) : super(key: key);

  @override
  State<Severe> createState() => _SevereState();
}

class _SevereState extends State<Severe> {
  List<int> numbers = List.generate(10, (index) => index + 1);
  int currentIndex = 0;

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
    Color(0xFFDE4937),
    ];

  @override
  void initState() {
    super.initState();
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
                    minimumSize: Size(70, 170),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex =
                          (currentIndex - 1 + numbers.length) % numbers.length;
                    });
                  },
                  child: const Icon(Icons.navigate_before,
                      size: 84.0, color: Colors.white),
                ),
                Center(
                  child: Text(
                    numbers[currentIndex].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 200.04,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: Size(70, 170),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex + 1) % numbers.length;
                    });
                  },
                  child: const Icon(Icons.navigate_next,
                      size: 84.0, color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {},
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
