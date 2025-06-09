// File: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web is not supported in this setup');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjEnW92EZyaztF49cYF4KDsPQXeXVyyJo',
    appId: '1:608970534032:android:3220a22c5c17b54c763c15',
    messagingSenderId: '608970534032',
    projectId: 'steel-soldier',
    storageBucket: 'steel-soldier.firebasestorage.app',
  );
}
