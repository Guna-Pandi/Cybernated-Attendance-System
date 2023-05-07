import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final _classController = TextEditingController();
  late String ip;
  Home({Key? key}) : super(key: key);

  void _stopScript(String? userid) async {
    // ignore: unused_local_variable
    final classname = _classController.text.trim();

    try {
      final response = await http.get(Uri.parse('http://$ip:5000/stopit'));
    } catch (e) {
      print("Error Connecting to Server $e");
    }
  }

  void _csvlist(BuildContext context, String? userid) {
    final classname = _classController.text.trim();
    Navigator.pushNamed(context, '/CsvPathsScreen',
        arguments: {'classname': classname, 'userid': userid});
    //Navigator.pushNamed(context,'/fire_camera');
  }

  Future<void> _signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print("Error Signing out");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? username = args?['username'] as String?;
    final String? userid = args?['userid'] as String?;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cybernated Attendance System',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 200,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 157, 173),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: -10,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(189, 204, 195, 97),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 80,
                  sigmaY: 80,
                ),
                child: Container(),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    _logo(),
                    const SizedBox(
                      height: 30,
                    ),
                    _loginLabel(),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        "Welcome Back $username",
                        style: GoogleFonts.josefinSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: TextField(
                        controller: _classController,
                        decoration: InputDecoration(
                          labelText: 'File Name',
                          hintText: 'Enter the File Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // adjust as needed
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 46.0),
                          child: GestureDetector(
                            onTap: () {
                              Future<Object?> myFuture =
                                  Navigator.pushNamed(context, '/IP');
                              myFuture.then((result) {
                                ip = result.toString();
                                // Do something with myString
                              });
                            },
                            child: Container(
                              width: 320,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(246, 198, 135, 238),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Center(
                                  child: Text(
                                    'Configure IP',
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 46.0),
                        //   child: _takeBtn(context, userid),
                        // ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _takeBtn(context, userid),
                        _stopBtn(context, userid),
                        //
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _makeBtn(context, userid),
                        _seeBtn(context, userid),
                        // _signoutBtn(context, userid),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 320,
                          child: _signoutBtn(context, userid),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _takeBtn(BuildContext context, String? userid) {
    return GestureDetector(
      onTap: () => _runScript(userid),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(244, 153, 255, 0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'Take Attendance',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stopBtn(BuildContext context, String? userid) {
    return GestureDetector(
      onTap: () => _stopScript(userid),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(198, 235, 62, 100),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'Stop Attendance',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _makeBtn(BuildContext context, String? userid) {
    return GestureDetector(
      onTap: () => _run2Script(userid),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(162, 62, 232, 235),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'Make Adjustment',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _seeBtn(BuildContext context, String? userid) {
    return GestureDetector(
      onTap: () => _csvlist(context, userid),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(221, 221, 235, 62),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'See Attendance',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signoutBtn(BuildContext context, String? userid) {
    return GestureDetector(
      onTap: () => _signout(context),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(190, 235, 157, 62),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'Sign Out',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                color: Color.fromARGB(228, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginLabel() {
    return Center(
      child: Text(
        "Cybernated Attendance System",
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 145, 255, 0),
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: SizedBox(
        // ignore: sort_child_properties_last
        child: Image.network("https://uilogos.co/img/logomark/kyan.png"),
        height: 80,
      ),
    );
  }

  void _runScript(String? userid) async {
    final classname = _classController.text.trim();
    try {
      final response = await http.get(Uri.parse(
          'http://$ip:5000/run-script?name=$classname&userid=$userid'));
      print(response.statusCode); // Print the HTTP response status code
      print(response.body); // Print the response body for further inspection
    } catch (e) {
      print(e);
      // Print any error or exception that occurs
    }
  }

  // void _runScript(String? userid) async {
  //   final classname = _classController.text.trim();
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://$ip:5000/run-script?name=$classname&userid=$userid'));
  //   } catch (e) {
  //     print(e);
  //   }
  //   print('success');
  // }

  void _run2Script(String? userid) async {
    final classname = _classController.text.trim();
    try {
      final response = await http.get(Uri.parse(
          'http://$ip:6000/run2-script?name=$classname&userid=$userid'));
    } catch (e) {
      print(e);
    }
    print('success');
  }
}
