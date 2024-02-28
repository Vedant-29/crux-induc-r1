import 'package:crux_induc/Screens/Signup_login/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crux_induc/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        automaticallyImplyLeading: false,        
        backgroundColor: theme.colorScheme.surfaceVariant,
        elevation: 0,
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: theme.colorScheme.surface,
            fontSize: 20,
            fontFamily: 'inter',
          ),
        ),
        actions: [],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                color: theme.colorScheme.surfaceVariant,
                child: Row(
                  children: [
                    Container(
                      width: 50, // Set the diameter of the circle
                      height: 50, // Set the diameter of the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.tertiary,
                        // Set the background color of the circle
                      ),  
                      child: const Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66,66), // Set the color of the logo
                            fontSize: 22, 
                          ),
                          // Set the size of the logo
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Your Name',
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: 16,
                            fontFamily: 'inter',
                          ),
                        ),
                        Text(
                          'Your Email',
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: 13,
                            fontFamily: 'inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                color: theme.colorScheme.tertiary,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: theme.colorScheme.inverseSurface,
                      size: 25,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Switch to dark mode',
                      style: TextStyle(
                        color: theme.colorScheme.inversePrimary,
                        fontSize: 16,
                        fontFamily: 'inter',
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  color: theme.colorScheme.tertiary,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: theme.colorScheme.inverseSurface,
                        size: 25,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: theme.colorScheme.inversePrimary,
                          fontSize: 16,
                          fontFamily: 'inter',
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