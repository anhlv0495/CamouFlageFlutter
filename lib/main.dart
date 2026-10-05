import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/game_state.dart';
import 'models/localization_provider.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  final prefs = await SharedPreferences.getInstance();
  final String initialLang = prefs.getString('selected_language') ?? 'en';
  final bool hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalizationProvider(initialLang)),
        ChangeNotifierProvider(create: (context) => GameState()),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camouflage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366f1),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFfdf6e3), // Off-white / paper color
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
      ),
      home: hasSeenOnboarding ? const HomeScreen() : const OnboardingScreen(),
    );
  }
}

