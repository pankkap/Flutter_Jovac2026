import 'package:flutter/material.dart';
import 'package:my_app/screens/API/add_edit_user_screen.dart';
import 'package:my_app/screens/API/api_service.dart';
import 'package:my_app/screens/API/model/user.dart';
import 'package:my_app/screens/API/user_details_screen.dart';

class APIHomeScreen extends StatefulWidget {
  const APIHomeScreen({super.key});

  @override
  State<APIHomeScreen> createState() => _APIHomeScreenState();
}

class _APIHomeScreenState extends State<APIHomeScreen> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      users = await ApiService.getUsers();
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Home Screem"),
        backgroundColor: Colors.deepOrange,
      ),
      body:isLoading
      ?Center(child: CircularProgressIndicator())
      :ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          User user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.id.toString()),
              ),
              title: Text(user.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email),
                  Text(user.phone),
                  Text(user.website),
                ],
              ),
              onTap: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>UserDetailsScreen(userId:user.id))
                );
              },
            ),
          );
        }
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () async{
            final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditUserScreen()));
            if(result == true)
            {
              await loadUsers();
            }
          },
        ),
    );
  }
}
