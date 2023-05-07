import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ipconfig extends StatelessWidget {
  const ipconfig({super.key});

  @override
  Widget build(BuildContext context) {
    final _ipController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(169, 47, 165, 0.8), // use ARGB colors
          title: Text("Configure IP"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
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
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      _logo(),
                      const SizedBox(
                        height: 50,
                      ),
                      _loginLabel(),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: TextField(
                              controller: _ipController,
                              decoration: InputDecoration(
                                labelText: 'IP Address',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 227, 248),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(197, 134, 235, 62),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(
                                  context, _ipController.text.trim()),
                              child: Text(
                                'Set Target IP',
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 410.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
        child: Image.network("https://uilogos.co/img/logomark/kyan.png"),
        height: 80,
      ),
    );
  }
}
