import 'package:crux_induc/Screens/Signup_login/components/submit_btn.dart';
import 'package:crux_induc/Screens/Signup_login/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WelcomeBackPage extends StatefulWidget {
  const WelcomeBackPage({super.key});

  @override
  State<WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  final customTextTheme1 = theme.textTheme.copyWith(
    bodyMedium: const TextStyle(fontSize: 15), // Adjust for bodyMedium style
  );

  // Text editing controllers
  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0.0, 16.0, 8.0),
                child: InkWell(
                  splashColor: theme.colorScheme.error,
                  focusColor: theme.colorScheme.error,
                  hoverColor: theme.colorScheme.error,
                  highlightColor: theme.colorScheme.error,
                    onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: theme.colorScheme.onPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Welcome back',
                style: TextStyle(
                  color: theme.colorScheme.inverseSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Please enter your name and phone number to create an account. We’ll send you an OTP.',
                style: customTextTheme1.bodyMedium,
              ),
              const SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone number',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InputTextField(
                    controller: phoneController,
                    labelText: '00000 00000',
                    obscureText: false,
                    prefixIcon: Icons.phone,
                    labelPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              BlueBtn(
                SubmitText: 'Get OTP',
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text.toString(),
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {},
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}