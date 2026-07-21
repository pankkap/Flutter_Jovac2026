import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              await AuthService().logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,

                MaterialPageRoute(builder: (_) => const LoginScreen()),

                (route) => false,
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const CircleAvatar(
                radius: 45,

                child: Icon(Icons.person, size: 50),
              ),

              const SizedBox(height: 25),

              const Text(
                "Welcome",

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 5,

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),

                        title: const Text("Email"),

                        subtitle: Text(user?.email ?? "No Email"),
                      ),

                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.fingerprint),

                        title: const Text("User UID"),

                        subtitle: Text(user?.uid ?? "No UID"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,

                    foregroundColor: Colors.white,
                  ),

                  icon: const Icon(Icons.logout),

                  label: const Text("Logout", style: TextStyle(fontSize: 18)),

                  onPressed: () async {
                    await AuthService().logout();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(builder: (_) => const LoginScreen()),

                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
