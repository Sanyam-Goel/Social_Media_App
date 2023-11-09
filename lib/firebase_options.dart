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
    apiKey: 'AIzaSyAvt2zK0NsVXllvehIEP0v9qp8SYulbSGI',
    appId: '1:492773426029:web:cb1053aa0c2788f6971064',
    messagingSenderId: '492773426029',
    projectId: 'instagram-tut-8a877',
    authDomain: 'instagram-tut-8a877.firebaseapp.com',
    storageBucket: 'instagram-tut-8a877.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvoxkhTmS0KcHAh9XG5-lbJqo5nHSWLiM',
    appId: '1:492773426029:android:2f3276b93687f2e2971064',
    messagingSenderId: '492773426029',
    projectId: 'instagram-tut-8a877',
    storageBucket: 'instagram-tut-8a877.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5rv_qk0GBGSv0NU1XxapmFaQBIdR5rNs',
    appId: '1:492773426029:ios:569419a2f6c323b4971064',
    messagingSenderId: '492773426029',
    projectId: 'instagram-tut-8a877',
    storageBucket: 'instagram-tut-8a877.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );
}