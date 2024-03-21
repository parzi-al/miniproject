import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  Mainscreen({Key? key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(221, 49, 47, 47),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: const Text("increment"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count--;
                });
              },
              child: const Text("decrement"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count=0;
                });
              },
              child: const Text("reset"),
            ),
            const Text(
              'Hello World',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(221, 32, 24, 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}