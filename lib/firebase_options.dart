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
    apiKey: "AIzaSyBibVis-rwSune37ls-IXXax164PCnTdSQ",
    authDomain: "skillswap-105ac.firebaseapp.com",
    projectId: "skillswap-105ac",
    storageBucket: "skillswap-105ac.firebasestorage.app",
    messagingSenderId: "501776748965",
    appId: "1:501776748965:web:ffa1726c77a018a304584c",
  );

  static const FirebaseOptions android = FirebaseOptions(
    appId: '1:501776748965:android:4959bfff4a3d0b9a04584c',
    apiKey: 'AIzaSyCXJnp97VftwAO615s2sX7MhkYF5yzFZbA',
    projectId: 'skillswap-105ac',
    messagingSenderId: '501776748965',
    storageBucket: 'skillswap-105ac.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    appId: '1:501776748965:ios:427762af92b4bb7204584c',
    apiKey: 'AIzaSyBgJnZJZet-x4C48lIBbmkylO_WTmgn-k4',
    projectId: 'skillswap-105ac',
    messagingSenderId: '501776748965',
    storageBucket: 'skillswap-105ac.firebasestorage.app',
    iosClientId: '501776748965-8sgir9gjeupp30m9euuj17juhlt5d943.apps.googleusercontent.com',
  );
}
