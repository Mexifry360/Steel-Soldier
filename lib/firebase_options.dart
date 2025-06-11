// File: lib/firebase_options.dart
    import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
    import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

    class DefaultFirebaseOptions {
      static FirebaseOptions get currentPlatform {
        if (kIsWeb) {
          // If you decide to support web later, you'd have web options here.
          // For now, let's keep your original intention or update it.
          // return web; // Placeholder if you add web configuration
          throw UnsupportedError('Web is not supported in this setup');
        }
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return android;
          case TargetPlatform.iOS: // Added iOS
            return ios; // You would need to define 'ios' FirebaseOptions
          // case TargetPlatform.macOS: // Example for macOS
          //   return macos;
          default:
            throw UnsupportedError(
              'DefaultFirebaseOptions are not supported for this platform.',
            );
        }
      }

      static const FirebaseOptions android = FirebaseOptions(
        apiKey: 'YOUR_ANDROID_API_KEY', // Replace with your actual key
        appId: 'YOUR_ANDROID_APP_ID', // Replace with your actual App ID
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'steel-soldier',
        storageBucket: 'steel-soldier.appspot.com', // Often includes .appspot.com
      );

      // Example iOS options - these values would come from your Firebase project
      static const FirebaseOptions ios = FirebaseOptions(
        apiKey: 'YOUR_IOS_API_KEY', // Replace with your actual key
        appId: 'YOUR_IOS_APP_ID', // Replace with your actual App ID
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'steel-soldier',
        storageBucket: 'steel-soldier.appspot.com',
        iosBundleId: 'YOUR_IOS_BUNDLE_ID', // e.g., com.example.steelSoldier
        // For iOS, you might also have:
        // androidClientId: '...', (if using Google Sign-In and need it for iOS too)
        // iosClientId: '...',
        // gcmSenderID: 'YOUR_MESSAGING_SENDER_ID', (older name for messagingSenderId)
      );

      // Placeholder for web if you add it later
      // static const FirebaseOptions web = FirebaseOptions(
      //   apiKey: "YOUR_WEB_API_KEY",
      //   appId: "YOUR_WEB_APP_ID",
      //   messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      //   projectId: "steel-soldier",
      //   authDomain: "steel-soldier.firebaseapp.com",
      //   storageBucket: "steel-soldier.appspot.com",
      // );
    }