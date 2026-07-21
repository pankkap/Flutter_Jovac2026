import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseConnectionTest extends StatelessWidget {
  const FirebaseConnectionTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Connected"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          "Firebase Connected Successfully",

          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
