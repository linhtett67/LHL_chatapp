import 'package:flutter/material.dart';
import 'package:food/pages/login.dart';
import 'package:food/pages/signup.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and signup page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(toggle: togglePages);
    }
    else {
      return SignupPage(toggle: togglePages);
    }
  }
}