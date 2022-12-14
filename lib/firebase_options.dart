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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA-r393mkEz4n8aIdDCvWepS0WCmh2SuhA',
    appId: '1:933311365585:web:b0e3f409b8482147e0a0f0',
    messagingSenderId: '933311365585',
    projectId: 'crazy-fa412',
    authDomain: 'crazy-fa412.firebaseapp.com',
    storageBucket: 'crazy-fa412.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBci_XTxOxl5fR6clkXU51yXwRHcGIs4oo',
    appId: '1:933311365585:android:4eccc95b74877857e0a0f0',
    messagingSenderId: '933311365585',
    projectId: 'crazy-fa412',
    storageBucket: 'crazy-fa412.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6hpSpY7XPNythT_inihOMpcwgFhkuq40',
    appId: '1:933311365585:ios:ac6321c6051e58afe0a0f0',
    messagingSenderId: '933311365585',
    projectId: 'crazy-fa412',
    storageBucket: 'crazy-fa412.appspot.com',
    iosClientId: '933311365585-u3sad4uq87blv6lus1lgdn1726foekeo.apps.googleusercontent.com',
    iosBundleId: 'com.crazy.light',
  );
}
