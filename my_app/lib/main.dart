import "package:flutter/material.dart";
import "package:my_app/screens/container_widget.dart";
import "package:my_app/screens/statefull_widget.dart";
import "package:my_app/screens/stateless_widget.dart";

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ContainerWidget()
    );
  }
}