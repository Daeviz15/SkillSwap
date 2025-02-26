import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDH8Mv6rl_FdI8ct-ERYMVE_OsLK3usDAY",
    authDomain: "chatify-ecd67.firebaseapp.com",
    projectId: "chatify-ecd67",
    storageBucket: "chatify-ecd67.appspot.com",
    messagingSenderId: "931156631355",
    appId: "1:931156631355:web:your_web_app_id_here",
  );

  static const FirebaseOptions android = FirebaseOptions(
    appId: '1:931156631355:android:8a0feb25f7deebacbda11e',
    apiKey: 'AIzaSyDH8Mv6rl_FdI8ct-ERYMVE_OsLK3usDAY',
    projectId: 'chatify-ecd67',
    messagingSenderId: '931156631355',
    storageBucket: 'chatify-ecd67.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    appId: '1:931156631355:ios:your_ios_app_id_here',
    apiKey: 'AIzaSyDH8Mv6rl_FdI8ct-ERYMVE_OsLK3usDAY',
    projectId: 'chatify-ecd67',
    messagingSenderId: '931156631355',
    storageBucket: 'chatify-ecd67.appspot.com',
    iosClientId: 'your_ios_client_id_here',
  );
}
