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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9U73PoDHc9NTSzOk33iq8DMw6rOhpn4U',
    appId: '1:1040640250076:android:ef30f1cfc479ab1efea419',
    messagingSenderId: '1040640250076',
    projectId: 'we-chat-84983',
    storageBucket: 'we-chat-84983.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaewd6fuvdQAbhKZfkj9i0HqzCd_WL87w',
    appId: '1:1040640250076:ios:20497dc4811c104efea419',
    messagingSenderId: '1040640250076',
    projectId: 'we-chat-84983',
    storageBucket: 'we-chat-84983.appspot.com',
    androidClientId: '1040640250076-hnjg71onlqbo391dh6fquu18m00al6bf.apps.googleusercontent.com',
    iosClientId: '1040640250076-3m0fi8utujvunt7hvli9hqn9nmhmk8t1.apps.googleusercontent.com',
    iosBundleId: 'com.example.weChat2023',
  );
}
