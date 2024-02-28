import 'package:crux_induc/Screens/Signup_login/signup_page.dart';
import 'package:crux_induc/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          // User is not logged in
          else {
            return SignUpPage();
          }
        }
      )
    );
  }
}