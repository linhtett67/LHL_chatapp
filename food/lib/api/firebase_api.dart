import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // fnction to initalize notifications
  Future<String?> initNotification() async {
    // request permission
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    print("start");
    final fCMToken = await _firebaseMessaging.getToken();
    print("done");

    // print the token 
    print('Token: $fCMToken');

    // return the token
    return fCMToken;
  }

  // function to handle receieved messages

  // function to initialize foreground and backgrond settings
}