import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";

import "package:my_app/screens/Databases/hive_database.dart";
import "package:my_app/screens/Databases/sqlite_database.dart";
import "package:my_app/screens/Navigation/screen1.dart";
import "package:my_app/screens/Navigation/screen2.dart";
import "package:my_app/screens/Navigation/screen3.dart";

void main() async{
  // Hive Database to be integrate with Flutter Application
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("studentBox");

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
      // home:PassingDataScreen1(),
      // home:TextFieldWidget(),
      // home:Calculator(),
      // home:TextFormFieldWidget(),
      // home:AlertDialogWidget(),
      // home:NotificationsWidgets(),
      // home:BottomSheetWidget(),
      // home:TableWidget(),
      // home:DataTableWidge(),
      // home:WebViewWidgetDemo(),
      // home:PickerDemoWidget(),
      // home:SharedPreferenceDemo(),
      // home:HiveDatabaseDemo(), 
      home:SQLiteDatabaseDemo(), 
      
  
      routes: {
        'S1':(context) => Screen1(),
        'S2':(context) => Screen2(),
        'S3':(context) => Screen3(),
      },
    );
  }
}