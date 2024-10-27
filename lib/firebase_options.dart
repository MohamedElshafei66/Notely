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
    apiKey: 'AIzaSyBYngJeibK_amIFhZAkYtlu23cClLX50EU',
    appId: '1:1032199481475:web:2ad681442f6c37ba7f13b6',
    messagingSenderId: '1032199481475',
    projectId: 'notely-18f04',
    authDomain: 'notely-18f04.firebaseapp.com',
    storageBucket: 'notely-18f04.appspot.com',
    measurementId: 'G-7KLL65KY6Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgcLpeT9xDoei4kfq-68UVRkRd0L6BaDI',
    appId: '1:1032199481475:android:c25c33323705a7c77f13b6',
    messagingSenderId: '1032199481475',
    projectId: 'notely-18f04',
    storageBucket: 'notely-18f04.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz-Lb_QQYf8EIlIgyc6d6U3hVZL84b6tk',
    appId: '1:1032199481475:ios:68d5d2e984d610b37f13b6',
    messagingSenderId: '1032199481475',
    projectId: 'notely-18f04',
    storageBucket: 'notely-18f04.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAz-Lb_QQYf8EIlIgyc6d6U3hVZL84b6tk',
    appId: '1:1032199481475:ios:68d5d2e984d610b37f13b6',
    messagingSenderId: '1032199481475',
    projectId: 'notely-18f04',
    storageBucket: 'notely-18f04.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYngJeibK_amIFhZAkYtlu23cClLX50EU',
    appId: '1:1032199481475:web:57958f712b46474a7f13b6',
    messagingSenderId: '1032199481475',
    projectId: 'notely-18f04',
    authDomain: 'notely-18f04.firebaseapp.com',
    storageBucket: 'notely-18f04.appspot.com',
    measurementId: 'G-P820FZWLP2',
  );
}
