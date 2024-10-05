import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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
    apiKey: 'AIzaSyC0W8dKVgc-D1en2wdvQPHJLbYUaA7lyQ8',
    appId: '1:1063123971943:android:50edff70ba49a479bf49c2',
    messagingSenderId: '1063123971943',
    projectId: 'dams-232cd',
    storageBucket: 'dams-232cd.appspot.com',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6bPfaspyrnQatXD0U24MBeA-rQMNaTsQ',
    appId: '1:1063123971943:ios:84b53ad009af437abf49c2',
    messagingSenderId: '1063123971943',
    projectId: 'dams-232cd',
    storageBucket: 'dams-232cd.appspot.com',
    iosBundleId: 'com.example.mypro11',
  );
}
