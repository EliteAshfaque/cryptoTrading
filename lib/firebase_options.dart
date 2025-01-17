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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDWN3stnJyp_0w6mBsVf4kdiq01hLMGxXY',
    appId: '1:101928434305:web:e6f3b217af36f0bbee6b80',
    messagingSenderId: '101928434305',
    projectId: 'onefx1-f2f63',
    authDomain: 'onefx1-f2f63.firebaseapp.com',
    storageBucket: 'onefx1-f2f63.appspot.com',
    measurementId: 'G-X7XGLJV17M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJfzag-HnIgq7zIXB1qSkpURoMPSiCFTo',
    appId: '1:101928434305:android:87998527d836d1aaee6b80',
    messagingSenderId: '101928434305',
    projectId: 'onefx1-f2f63',
    storageBucket: 'onefx1-f2f63.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzpE_ZHtisRwMktWflvmg7Sx9-_V6BMdg',
    appId: '1:101928434305:ios:91903e1eb4b4aba2ee6b80',
    messagingSenderId: '101928434305',
    projectId: 'onefx1-f2f63',
    storageBucket: 'onefx1-f2f63.appspot.com',
    iosBundleId: 'com.solution.onefx1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWN3stnJyp_0w6mBsVf4kdiq01hLMGxXY',
    appId: '1:101928434305:web:231b4ed691d89b90ee6b80',
    messagingSenderId: '101928434305',
    projectId: 'onefx1-f2f63',
    authDomain: 'onefx1-f2f63.firebaseapp.com',
    storageBucket: 'onefx1-f2f63.appspot.com',
    measurementId: 'G-FPMH1KS7GV',
  );

}