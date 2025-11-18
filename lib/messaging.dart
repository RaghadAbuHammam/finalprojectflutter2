import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

Future <void> magHandler (RemoteMessage massage)async {
  print(massage.data);
}

class MassagingClass{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future <void> init () async {
    await _firebaseMessaging.requestPermission();

    String? token =await _firebaseMessaging.getAPNSToken();

    print('tokecn : ${token}');

    FirebaseMessaging.onBackgroundMessage(magHandler);
  }
}