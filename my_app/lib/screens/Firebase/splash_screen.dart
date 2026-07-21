import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  //----------------------------------------------------
  // Check Current User
  //----------------------------------------------------

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (AuthService().currentUser != null) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const FlutterLogo(size: 100),

            const SizedBox(height: 20),

            const Text(
              "Firebase Authentication",

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(),

            const SizedBox(height: 20),

            Text(
              "Checking Login...",

              style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
