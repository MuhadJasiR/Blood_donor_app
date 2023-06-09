import 'package:firbase_auth/view/home/home_screen.dart';
import 'package:firbase_auth/view/auth/login/login_screen.dart';
import 'package:firbase_auth/view/auth/signup/signup_screen.dart';
import 'package:firbase_auth/view/home/update_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/update": (context) => UpdateDetails()},
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SignUpScreen();
          }
        },
      ),
    );
  }
}
