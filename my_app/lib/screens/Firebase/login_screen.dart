import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>(); 

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  //----------------------------------------------------
  // Login Method
  //----------------------------------------------------

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await AuthService().login(
        email: emailController.text.trim(),

        password: passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),

          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              const SizedBox(height: 40),

              const Icon(Icons.lock, size: 100, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                "Firebase Login",

                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              //----------------------------------
              // Email
              //----------------------------------
              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: "Email",

                  prefixIcon: Icon(Icons.email),

                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // Password
              //----------------------------------
              TextFormField(
                controller: passwordController,

                obscureText: obscurePassword,

                decoration: InputDecoration(
                  labelText: "Password",

                  prefixIcon: const Icon(Icons.lock),

                  border: const OutlineInputBorder(),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Password";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 Characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              //----------------------------------
              // Login Button
              //----------------------------------
              SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : login,

                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Login", style: TextStyle(fontSize: 20)),
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // Register
              //----------------------------------
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },

                child: const Text("Create New Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
