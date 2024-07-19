import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/services/auth/auth_gate.dart';
import 'package:food/services/auth/auth_service.dart';
import 'package:food/components/mybutton.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // auth service
  final authService = AuthService();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    authService.sendEmailVerificationLink();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        // Cancel the timer
        timer.cancel();

        // Go to AuthPage
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const AuthGate())
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text("We have sent an email for verification. Please click the link attached to the email to verify your account. If no email is received. press the following the button."),

              const SizedBox(height: 20),

              MyButton(
                btnName: 'Resend', 
                onTap: () async {
                  // Resend email verification link
                  authService.sendEmailVerificationLink();
                })
            ],
            ),
          ),
        ),
    );
  }
}