import 'package:finalwala_app/signup_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'personalization_page.dart';
import 'mood_page.dart';  // Import the MoodPage
import 'playlist_page.dart';
import 'package:firebase_core/firebase_core.dart';// Import the PlaylistPage

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodMate',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const LoginPage(),  // Start with the LoginPage
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/personalization': (context) => PersonalizationPage(),
        '/mood': (context) => MoodPage(),  // Add route for MoodPage
        '/playlist': (context) => PlaylistPage(),  // Add route for PlaylistPage
            // Route to JournalPage (if exists)
      },
    );
  }
}
