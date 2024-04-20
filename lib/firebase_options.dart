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
    apiKey: 'AIzaSyDIVS1-qlA7kKNnPlrEA5IhSkmN0ZsZgO4',
    appId: '1:426304167882:web:fd3a19471caf630c593933',
    messagingSenderId: '426304167882',
    projectId: 'ent-clinic-b89c8',
    authDomain: 'ent-clinic-b89c8.firebaseapp.com',
    storageBucket: 'ent-clinic-b89c8.appspot.com',
    measurementId: 'G-767J75FKS9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNYUVyxYuyJohhcwJmm7BPTmP8-8mxmbA',
    appId: '1:426304167882:android:e125931d454682df593933',
    messagingSenderId: '426304167882',
    projectId: 'ent-clinic-b89c8',
    storageBucket: 'ent-clinic-b89c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdwu3vn2OsP3CdU6op_WF-eVYe_DScwpM',
    appId: '1:426304167882:ios:2cfd134345b2dc0f593933',
    messagingSenderId: '426304167882',
    projectId: 'ent-clinic-b89c8',
    storageBucket: 'ent-clinic-b89c8.appspot.com',
    iosBundleId: 'com.example.entClinic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdwu3vn2OsP3CdU6op_WF-eVYe_DScwpM',
    appId: '1:426304167882:ios:2cfd134345b2dc0f593933',
    messagingSenderId: '426304167882',
    projectId: 'ent-clinic-b89c8',
    storageBucket: 'ent-clinic-b89c8.appspot.com',
    iosBundleId: 'com.example.entClinic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDIVS1-qlA7kKNnPlrEA5IhSkmN0ZsZgO4',
    appId: '1:426304167882:web:90c9544c71c1f4d1593933',
    messagingSenderId: '426304167882',
    projectId: 'ent-clinic-b89c8',
    authDomain: 'ent-clinic-b89c8.firebaseapp.com',
    storageBucket: 'ent-clinic-b89c8.appspot.com',
    measurementId: 'G-0V52G550YC',
  );
}
