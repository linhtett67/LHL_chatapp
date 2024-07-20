import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // fnction to initalize notifications
  Future<String?> initNotification() async {
  try {
    await _firebaseMessaging.requestPermission();
    print("start");
    final fCMToken = await _firebaseMessaging.getToken();
    print("done");
    print('Token: $fCMToken');
    return fCMToken;
  } catch (e) {
    print('Error initializing Firebase Messaging: $e');
    return null;
  }
  }

  // function to handle receieved messages

  // function to initialize foreground and backgrond settings
}