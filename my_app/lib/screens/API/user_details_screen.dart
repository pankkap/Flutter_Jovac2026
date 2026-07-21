import 'package:flutter/material.dart';
import 'package:my_app/screens/API/add_edit_user_screen.dart';

import './model/user.dart';
import './api_service.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  User? user;

  bool loading = true;
  bool dataChanged = false;

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {
    user = await ApiService.getUser(widget.userId);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 45,

                      child: Text(
                        user!.id.toString(),

                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  buildRow("Name", user!.name),

                  buildRow("Email", user!.email),

                  buildRow("Phone", user!.phone),

                  buildRow("Website", user!.website),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => AddEditUserScreen(user: user),
                              ),
                            );

                            if (result == true) {
                              dataChanged = true;

                              await loadUser();
                            }
                          },

                          icon: const Icon(Icons.edit),

                          label: const Text("Edit"),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white
                          ),

                          onPressed: () async {
                            bool deleted = await ApiService.deleteUser(
                              user!.id,
                            );

                            if (deleted) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("User Deleted Successfully"),
                                ),
                              );

                              Navigator.pop(context, true);
                            } else {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to Delete User"),
                                ),
                              );
                            }
                          },

                          icon: const Icon(Icons.delete, ),

                          label: const Text("Delete", ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,

                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, dataChanged);
                      },

                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 120,

            child: Text(
              "$title :",

              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
