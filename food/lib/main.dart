import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/api/firebase_api.dart';
import 'package:food/services/auth/auth_gate.dart';
import 'package:food/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

