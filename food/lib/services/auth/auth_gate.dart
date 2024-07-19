import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/services/auth/login_or_signup.dart';
import 'package:food/pages/email_verification.dart';
import 'package:food/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;

            if (user != null && user.emailVerified) {
              return HomePage();
            } else {
              return const VerificationScreen();
            }
          } else {
            return const LoginOrSignup();
          }
        }
      ),
    );
  }
}
