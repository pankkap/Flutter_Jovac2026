import "package:flutter/material.dart";
import "package:my_app/screens/Navigation/bottom_navigation.dart";
import "package:my_app/screens/Navigation/drawer_navigation.dart";
import "package:my_app/screens/Navigation/pass_data_screen1.dart";
import "package:my_app/screens/Navigation/push_navigation.dart";
import "package:my_app/screens/Navigation/screen1.dart";
import "package:my_app/screens/Navigation/screen2.dart";
import "package:my_app/screens/Navigation/screen3.dart";
import "package:my_app/screens/Navigation/tabbar_navigation.dart";

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:ContainerWidget()
      // home:SafeAreaWidget()
      // home:RowColumnWidgets()
      // home:StackWidget()
      // home:SpacerWidget()
      // home:AlignWidget()
      // home:WrapWidget()
      // home:ExpandedWidget()
      // home:FlexibleWidget()
      // home:ListViewWidget()
      // home:ListTileWidget()
      // home:CardWidget()
      // home:InkWellWidget()
      // home:ImageWidget()
      // home:StatelessButtonsWidget()
      // home:StatefulButtons()
      // home:HomeScreen(),
      // home:PushNvaigation1(),
      // home:DrawerNavigationWidget(),
      // home:BottomNavigationWidget(),
      // home:TabbarNavigationWidget(),
      home:PassingDataScreen1(),
      routes: {
        'S1':(context) => Screen1(),
        'S2':(context) => Screen2(),
        'S3':(context) => Screen3(),
      },
    );
  }
}