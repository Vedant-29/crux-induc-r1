import 'package:crux_induc/Screens/Signup_login/get_started_page.dart';
import 'package:crux_induc/Screens/Signup_login/welcome_back_page.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';
import 'package:crux_induc/services/auth_service.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/buffer-img.jpg',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)  ,
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Gain total control of your money',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Become your own money manager and make every cent count',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 23),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.circle_rounded,
                                  color: theme.colorScheme.secondary,
                                  size: 10,
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.circle_rounded,
                                  color: theme.colorScheme.secondary,
                                  size: 10,
                                ),
                  
                              ],
                            ),
                          const SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: SizedBox(
                              width: double.infinity, 
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GetStartedPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onSecondaryContainer,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone, size: 21),
                                    SizedBox(width: 15),
                                    Text('Sign up with phone'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: SizedBox(
                              width: double.infinity, 
                              height: 45,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow,
                                      blurRadius: 2,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ElevatedButton(
                                  onPressed: AuthService().signInWithGoogle,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.tertiary,
                                    foregroundColor: theme.colorScheme.primaryContainer,
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'lib/images/google-logo.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 15),
                                      const Text('Sign up with google'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeBackPage(),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Already have an account? ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: ' Login ',
                                        style: TextStyle(color: Color.fromARGB(255, 255, 202, 28)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}