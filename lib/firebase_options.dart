// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDDOQUaX7xGtSYRCB-hT9CM5SapayaroZE',
    appId: '1:1091091501344:web:aea288424434128e960745',
    messagingSenderId: '1091091501344',
    projectId: 'trialapp-7f05e',
    authDomain: 'trialapp-7f05e.firebaseapp.com',
    storageBucket: 'trialapp-7f05e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6wHsTOOBnFY7zXH4BdvNAXRb1RXa7wVA',
    appId: '1:1091091501344:android:e7c6f575c80e0285960745',
    messagingSenderId: '1091091501344',
    projectId: 'trialapp-7f05e',
    storageBucket: 'trialapp-7f05e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAE9u80PiqD09G6v9Ghv33WsBuoNtg2Sk',
    appId: '1:1091091501344:ios:7a19e125d2148dbf960745',
    messagingSenderId: '1091091501344',
    projectId: 'trialapp-7f05e',
    storageBucket: 'trialapp-7f05e.appspot.com',
    iosBundleId: 'com.example.campusSell',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAE9u80PiqD09G6v9Ghv33WsBuoNtg2Sk',
    appId: '1:1091091501344:ios:7a19e125d2148dbf960745',
    messagingSenderId: '1091091501344',
    projectId: 'trialapp-7f05e',
    storageBucket: 'trialapp-7f05e.appspot.com',
    iosBundleId: 'com.example.campusSell',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDDOQUaX7xGtSYRCB-hT9CM5SapayaroZE',
    appId: '1:1091091501344:web:a0210f31dc16a811960745',
    messagingSenderId: '1091091501344',
    projectId: 'trialapp-7f05e',
    authDomain: 'trialapp-7f05e.firebaseapp.com',
    storageBucket: 'trialapp-7f05e.appspot.com',
  );
}