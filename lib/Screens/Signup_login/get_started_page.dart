import 'package:crux_induc/Screens/Signup_login/components/submit_btn.dart';
import 'package:crux_induc/Screens/Signup_login/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crux_induc/Screens/Signup_login/otp_verify_page.dart';


class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  
  final customTextTheme1 = theme.textTheme.copyWith(
    bodyMedium: const TextStyle(fontSize: 15), // Adjust for bodyMedium style
  );

  // Text editing controllers
  final nameController = TextEditingController();
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
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
                'Get Started',
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
                    'Name',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InputTextField(
                    controller: nameController,
                    labelText: 'Enter your name',
                    obscureText: false,
                    prefixIcon: Icons.person_outline,
                    labelPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),

                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InputTextField(
                    controller: phoneController,
                    labelText: '+91 0000 0000',
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
                final phoneNumberVal = '+91 ' + phoneController.text;
                  if (phoneNumberVal == null ||
                      phoneNumberVal.isEmpty ||
                      phoneNumberVal.length <= 3 ||
                      !phoneNumberVal.startsWith('+')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Phone Number is required and has to start with +.'),
                      ),
                    );
                    return;
                  }
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text.toString(),
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerifyPage(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                    },
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