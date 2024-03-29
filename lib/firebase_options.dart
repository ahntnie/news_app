// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCwoELwQhhnn2_lZ_Krvr4XUthk4C81U2M',
    appId: '1:194149615725:web:7ead5269c164b79f375764',
    messagingSenderId: '194149615725',
    projectId: 'newsapp-ab733',
    authDomain: 'newsapp-ab733.firebaseapp.com',
    storageBucket: 'newsapp-ab733.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkbuJ4DrlkHYyEMzTkqpANgujVYzU3BLY',
    appId: '1:194149615725:android:a31b0cf8ed84225c375764',
    messagingSenderId: '194149615725',
    projectId: 'newsapp-ab733',
    storageBucket: 'newsapp-ab733.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNX5Dgs6EB_HMCd6lo1V4GgiOhCfq8otw',
    appId: '1:194149615725:ios:415067beda5b0d14375764',
    messagingSenderId: '194149615725',
    projectId: 'newsapp-ab733',
    storageBucket: 'newsapp-ab733.appspot.com',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNX5Dgs6EB_HMCd6lo1V4GgiOhCfq8otw',
    appId: '1:194149615725:ios:022853bcecdfd63e375764',
    messagingSenderId: '194149615725',
    projectId: 'newsapp-ab733',
    storageBucket: 'newsapp-ab733.appspot.com',
    iosBundleId: 'com.example.newsApp.RunnerTests',
  );
}
