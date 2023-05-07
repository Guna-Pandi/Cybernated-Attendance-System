import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cybernated Attendance System',
      theme: ThemeData.dark(), // set the app theme to dark mode
      home: Scaffold(
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
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        _logo(),
                        const SizedBox(
                          height: 60,
                        ),
                        _loginLabel(),
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email ID 📧",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(199, 255, 255, 255),
                                fontSize: 15,
                              ),
                              fillColor: Color.fromARGB(220, 180, 180, 180),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color:
                                  Colors.black, // set the text color to black
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password 🔑",
                              hintStyle: TextStyle(
                               color: Color.fromARGB(199, 255, 255, 255),
                                fontSize: 15,
                              ),
                              fillColor: Color.fromARGB(220, 180, 180, 180),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color:
                                  Colors.black, // set the text color to black
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        _loginBtn(context),
                        const SizedBox(
                          height: 80,
                        ),
                        _signUpLabel("Don't have an account 8et?",
                            Color.fromARGB(255, 255, 255, 255)),
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color.fromARGB(255, 5, 164, 243),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 93,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpLabel(String label, Color textColor) {
    return Text(
      label,
      style: GoogleFonts.josefinSans(
        textStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff008fff),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: () => _login(context),
        child: Text(
          "Login",
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelTextInput(String label, String hintText, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color(0xff8fa1b6),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        TextField(
          obscureText: isPassword,
          cursorColor: Colors.red,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.josefinSans(
              textStyle: const TextStyle(
                color: Color(0xffc5d2e1),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdfe8f3)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginLabel() {
    return Center(
      child: Text(
        "Login",
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 145, 255, 0),
            fontWeight: FontWeight.w900,
            fontSize: 38,
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

  Future<void> _login(BuildContext context) async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        final String? username = FirebaseAuth.instance.currentUser?.displayName;
        final String? userid = FirebaseAuth.instance.currentUser?.uid;

        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {'username': username, 'userid': userid},
        );
      });
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message ?? 'An unknown error occurred';
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
