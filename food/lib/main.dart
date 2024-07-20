import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/api/firebase_api.dart';
import 'package:food/services/auth/auth_gate.dart';
import 'package:food/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:food/services/fcm_token_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Get fcm token
  String? token = await FirebaseApi().initNotification();

  // Make the token universally accessible through provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FcmTokenProvider()..setFcmToken(token)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
