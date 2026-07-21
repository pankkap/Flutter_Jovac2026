import 'package:flutter/material.dart';

import './api_service.dart';
import './model/user.dart';

class AddEditUserScreen extends StatefulWidget {
  final User? user;

  const AddEditUserScreen({
    super.key,
    this.user,
  });

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController websiteController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    // If user is passed, populate the form
    if (widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phone;
      websiteController.text = widget.user!.website;
    }
  }

  //-----------------------------------------
  // SAVE USER (POST)
  //-----------------------------------------

  Future<void> saveUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    User user = User(
      id: 0,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      website: websiteController.text.trim(),
    );

    try {
      await ApiService.createUser(user);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Added Successfully"),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //-----------------------------------------
  // UPDATE USER (PUT)
  //-----------------------------------------

  Future<void> updateUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    User updatedUser = User(
      id: widget.user!.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      website: websiteController.text.trim(),
    );

    try {
      await ApiService.updateUser(updatedUser);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Updated Successfully"),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //-----------------------------------------
  // Dispose Controllers
  //-----------------------------------------

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  //-----------------------------------------
  // UI
  //-----------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? "Add User" : "Update User",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: phoneController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Phone";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: websiteController,

                decoration: const InputDecoration(
                  labelText: "Website",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Website";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,

                child: ElevatedButton.icon(
                  icon: Icon(
                    widget.user == null
                        ? Icons.save
                        : Icons.update,
                  ),

                  label: Text(
                    widget.user == null
                        ? "Save User"
                        : "Update User",
                    style: const TextStyle(fontSize: 18),
                  ),

                  onPressed: loading
                      ? null
                      : () {
                          if (widget.user == null) {
                            saveUser();
                          } else {
                            updateUser();
                          }
                        },
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 55,

                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}