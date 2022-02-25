import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'screens/login_signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBQboBWWKseSIultCYzClNSIPyTwrsS590",
            appId: "1:547504653893:web:7099fe0d1408bc922d052c",
            messagingSenderId: "547504653893",
            projectId: "bookstore-e040e",
            storageBucket: "bookstore-e040e.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'BookStore App', home: LoginSignupScreen());
  }
}
