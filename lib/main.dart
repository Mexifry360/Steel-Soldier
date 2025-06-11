import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('onboarding_complete') ?? false;

  runApp(SteelSoldierApp(startScreen: isFirstTime ? const PinVerifyScreen() : const OnboardingSetupScreen()));
}

class SteelSoldierApp extends StatelessWidget {
  const SteelSoldierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steel Soldier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const OnboardingScreen(),
    );
  }
}
