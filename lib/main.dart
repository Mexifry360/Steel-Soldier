import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/onboarding_screen.dart';
import 'screens/pin_verify_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/supervisor_view.dart';
import 'screens/settings_screen.dart';
import 'screens/biometric_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  final user = FirebaseAuth.instance.currentUser;

  runApp(SteelSoldierApp(
    startScreen: onboardingComplete
        ? (user != null ? const PinVerifyScreen() : const LoginScreen())
        : const OnboardingScreen(),
  ));
}

class SteelSoldierApp extends StatelessWidget {
  final Widget startScreen;
  const SteelSoldierApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steel Soldier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: startScreen,
      routes: {
        '/login': (_) => const LoginScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/goals': (_) => const GoalsScreen(),
        '/supervisor': (_) => const SupervisorView(),
        '/settings': (_) => const SettingsScreen(),
        '/biometric-login': (_) => const BiometricLoginScreen(),
      },
    );
  }
}
