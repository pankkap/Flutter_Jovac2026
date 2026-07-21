import 'dart:convert';

import 'package:my_app/screens/API/model/user.dart';
import "package:http/http.dart" as http;
class ApiService{
  static const String baseUrl = 
  // "https://jsonplaceholder.typicode.com/users";
  "http://172.20.10.4:3000/api/users";
  


  // Get All Users
  static Future<List <User>> getUsers() async{
    final response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode ==200)
    {
        List<dynamic> jsonData = jsonDecode(response.body);
        
        return jsonData
          .map((json) => User.fromJson(json))
          .toList();
    }else{
      throw Exception("Failed to load users");
    }    
  }

  
  // Get Single Users
  static Future<User> getUser(int id) async{
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if(response.statusCode ==200)
    {
        print("Calling API...");      
        return User.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to load user");
    }    
  }

  // Post New User
static Future<User> createUser(
      User user) async {

    final response = await http.post(

      Uri.parse(baseUrl),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode(
        user.toJson(),
      ),

    );

    if (response.statusCode == 201) {

      return User.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception("Failed to Create User");

    }
  }
 
 // Update the User
 static Future<User> updateUser(
      User user) async {

    final response = await http.put(

      Uri.parse("$baseUrl/${user.id}"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode(
        user.toJson(),
      ),

    );

    if (response.statusCode == 200) {

      return User.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception("Failed to Update User");

    }
  }


  // Delete the user
  static Future<bool> deleteUser(int id) async{
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
    );

    return response.statusCode == 200 || response.statusCode == 204;
  }
}