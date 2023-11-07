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
    apiKey: 'AIzaSyCO0_1InENvtG5VwMN5pUYC5ny63c9gNSY',
    appId: '1:555508651647:web:41b937ec661abca264514a',
    messagingSenderId: '555508651647',
    projectId: 'recipestash-6be03',
    authDomain: 'recipestash-6be03.firebaseapp.com',
    storageBucket: 'recipestash-6be03.appspot.com',
    measurementId: 'G-5R6W7000XY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyqNRwcvle89V7iRHtv0Q5nivcHCK7bNk',
    appId: '1:555508651647:android:6e4379b6c0eaaff664514a',
    messagingSenderId: '555508651647',
    projectId: 'recipestash-6be03',
    storageBucket: 'recipestash-6be03.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMz9Z1DH961Ri7Yr4yhlKiKb1plEoiTHA',
    appId: '1:555508651647:ios:0890bccf3c3902a964514a',
    messagingSenderId: '555508651647',
    projectId: 'recipestash-6be03',
    storageBucket: 'recipestash-6be03.appspot.com',
    iosBundleId: 'com.example.recipestash',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMz9Z1DH961Ri7Yr4yhlKiKb1plEoiTHA',
    appId: '1:555508651647:ios:82daa6650692775b64514a',
    messagingSenderId: '555508651647',
    projectId: 'recipestash-6be03',
    storageBucket: 'recipestash-6be03.appspot.com',
    iosBundleId: 'com.example.recipestash.RunnerTests',
  );
}