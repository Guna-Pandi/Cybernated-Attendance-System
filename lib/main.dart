import 'package:cybernated_attendence_system/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:cybernated_attendence_system/prog.dart';
import 'package:cybernated_attendence_system/Authentication/register.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';
import 'package:cybernated_attendence_system/csvPathsScreen.dart';
import 'package:cybernated_attendence_system/ipconfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      routes: {
        //'/': (context) => Register(),
        '/': (context) => Register(),
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/CsvPathsScreen': (context) => CsvPathsScreen(),
        '/IP': (context) => ipconfig(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
