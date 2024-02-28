import 'package:crux_induc/Screens/Signup_login/auth_page.dart';
import 'package:crux_induc/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const AuthPage(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Image.asset(
          'lib/images/app-logo.png',
          fit: BoxFit.cover,
          ), 
      ),
    );
  }
}