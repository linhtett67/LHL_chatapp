import 'package:flutter/foundation.dart';

class FcmTokenProvider with ChangeNotifier {
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  void setFcmToken(String? token) {
    _fcmToken = token;
    notifyListeners();
  }
}
