import 'package:crux_induc/Screens/Signup_login/components/submit_btn.dart';
import 'package:crux_induc/Screens/Signup_login/components/textfield_without_icon.dart';
import 'package:crux_induc/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';

class OtpVerifyPage extends StatefulWidget {
  final String verificationId;

  const OtpVerifyPage({
    super.key,
    required this.verificationId,
  });



  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final customTextTheme1 = theme.textTheme.copyWith(
    bodyMedium: const TextStyle(fontSize: 15), // Adjust for bodyMedium style
  );

  // Text editing controllers
  final otpController = TextEditingController();

  void log(String message) {
    // Your implementation for logging, for example, printing to the console
    print(message);
  }

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
                'OTP Verification',
                style: TextStyle(
                  color: theme.colorScheme.inverseSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Enter the verification code we just sent on your entered phone number.',
                style: customTextTheme1.bodyMedium,
              ),
              const SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OTP',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InputTextFieldWithoutPrefix(
                    controller: otpController,
                    labelText: 'Enter the OTP',
                    obscureText: false,
                    prefixIcon: null,
                    labelPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              BlueBtn(
                SubmitText: 'Verify',
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text);
                    FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  } catch (e) {
                    log(e.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
