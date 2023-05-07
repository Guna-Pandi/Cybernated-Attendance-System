import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _unameController = TextEditingController();
  bool _isLoading = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    setState(() {
      _isEmailValid = EmailValidator.validate(email);
    });
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _unameController.text.trim();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(username);
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The password provided is too weak.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The account already exists for that email.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                          height: 100,
                        ),
                        _logo(),
                        const SizedBox(
                          height: 60,
                        ),
                        _loginLabel(),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Enter Your Email ID 📧",
                              errorText: _isEmailValid
                                  ? null
                                  : 'Please enter a valid email',
                              errorStyle: TextStyle(
                                color: Color.fromARGB(
                                    255, 255, 17, 0), // set the color here
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(199, 255, 255, 255),
                                fontSize: 15,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(220, 180, 180, 180),
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
                            onChanged: (value) {
                              final email = value.trim();
                              setState(() {
                                _isEmailValid = EmailValidator.validate(email);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Your Password 🔑",
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
                          height: 40,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: _unameController,
                            decoration: InputDecoration(
                              hintText: 'Enter Username 📛',
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
                          height: 50,
                        ),
                        _regBtn(context),
                        const SizedBox(
                          height: 80,
                        ),
                        _signUpLabel("Already have an Account !",
                            const Color.fromARGB(255, 255, 255, 255)),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color.fromARGB(255, 5, 164, 243),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 55,
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

  Widget _regBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xff008fff),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextButton(
          onPressed: _isEmailValid
              ? () => _register()
              : null, // remove context argument from _register function call
          child: _isLoading
              ? CircularProgressIndicator()
              : Text(
                  'Register',
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
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
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        TextField(
          obscureText: isPassword,
          cursorColor: Color.fromARGB(255, 149, 190, 152),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.josefinSans(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
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
        "Register",
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
}
