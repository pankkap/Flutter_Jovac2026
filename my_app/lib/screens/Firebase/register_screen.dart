import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  //--------------------------------------------------------
  // Register
  //--------------------------------------------------------

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await AuthService().register(
        email: emailController.text.trim(),

        password: passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),

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
        title: const Text("Register"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.person_add, size: 90, color: Colors.blue),

              const SizedBox(height: 15),

              const Text(
                "Create New Account",

                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              //------------------------------------------------
              // Name
              //------------------------------------------------
              TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: "Full Name",

                  prefixIcon: Icon(Icons.person),

                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Name";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // Email
              //------------------------------------------------
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

                  if (!value.contains("@")) {
                    return "Enter Valid Email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // Password
              //------------------------------------------------
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

              const SizedBox(height: 20),

              //------------------------------------------------
              // Confirm Password
              //------------------------------------------------
              TextFormField(
                controller: confirmPasswordController,

                obscureText: obscureConfirmPassword,

                decoration: InputDecoration(
                  labelText: "Confirm Password",

                  prefixIcon: const Icon(Icons.lock),

                  border: const OutlineInputBorder(),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                validator: (value) {
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              //------------------------------------------------
              // Register Button
              //------------------------------------------------
              SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : register,

                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Register", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
