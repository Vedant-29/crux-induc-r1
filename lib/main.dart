import 'package:flutter/material.dart';   
import 'package:google_fonts/google_fonts.dart';
import 'package:crux_induc/Screens/Splash_screen/splash_page_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); 
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const SplashPage(),
    );
  }
}

final theme = ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 255, 202, 28),
      primary: Color.fromARGB(255, 255, 202, 28), // Main theme color blue
      secondary: const Color.fromARGB(255, 224, 224, 224), // grey.shade300 color
      tertiary: const Color.fromARGB(255,255, 255, 255), // plain white color
      scrim: const Color.fromARGB(255,245, 245, 245),

      // Bottom sheet colors  
      onPrimary: const Color.fromARGB(255, 111, 111, 111),  // - textfield 1 font color
      onSecondary: const Color.fromARGB(255, 177, 177, 177), // - textfield 2 font color
      onTertiary: const Color.fromARGB(255, 244, 244, 244), // textfield background
      onBackground: const Color.fromARGB(255, 207, 233, 208), // reset button background
      onSurface: const Color.fromARGB(255, 0, 125, 25), // reset button foreground color
      onPrimaryContainer: const Color.fromARGB(153, 0, 0, 0), // Heading color for each textfield
      // ···

      onError: const Color.fromARGB(0, 0, 0, 0), // Colors.transparent
      surface: const Color.fromARGB(255, 0, 0, 0), // Colors.black

      background: const Color.fromARGB(255, 66, 66, 66), // Main heading text color

      onSecondaryContainer: const Color.fromARGB(255, 252, 252, 252), 

      surfaceVariant: const Color.fromARGB(255, 238, 238, 238), // Border color

      // Profile page colors
      inverseSurface: const Color.fromARGB(255, 97, 97, 97),
      inversePrimary: const Color.fromARGB(255, 33, 33, 33),

      shadow: const Color.fromARGB(30, 0, 0, 0),

      brightness: Brightness.dark,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w600,
      ),

      titleLarge: GoogleFonts.inter(
        color: const Color.fromARGB(255, 33, 35, 37),
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),

      titleMedium: GoogleFonts.inter(
        color: const Color.fromARGB(255, 33, 35, 37),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.25,
      ),

      bodyMedium: GoogleFonts.inter(
        color: const Color.fromARGB(255, 145, 145, 159),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.pacifico(),
    ),
);
