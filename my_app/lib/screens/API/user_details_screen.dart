import 'package:flutter/material.dart';
import 'package:my_app/screens/API/api_service.dart';
import 'package:my_app/screens/API/model/user.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;
  const UserDetailsScreen({super.key, required this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  User? user;
  bool isloading = true;
  @override
  void initState(){
    super.initState();
    loadUser();
  }
  Future <void> loadUser()async{
    user = await ApiService.getUser(widget.userId);
    setState(() {
      isloading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
        backgroundColor: Colors.blue,
      ),
      body: isloading?Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              CircleAvatar(
                radius: 45,
              child: Text(user!.id.toString()),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 120,
                  child: Text("Name:"),
                  ),
                  Expanded(child: Text("${user!.name}"))
                ],
              )
              ,
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 120,
                  child: Text("Email:"),
                  ),
                  Expanded(child: Text("${user!.email}"))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 120,
                  child: Text("Phone:"),
                  ),
                  Expanded(child: Text("${user!.phone}"))
                ],
              ),
              
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 120,
                  child: Text("Website:"),
                  ),
                  Expanded(child: Text("${user!.website}"))
                ],
              ),
          ],
        ),
      )
    );
  }
}