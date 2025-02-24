import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/firebase_options.dart';
import 'package:skill_swap/screens/login_screen.dart';
import 'package:skill_swap/screens/navigation.dart';
import 'package:skill_swap/screens/onboarding_screen.dart';
import 'package:skill_swap/screens/profile_screen.dart';
import 'package:skill_swap/screens/home_screen.dart';

import 'package:skill_swap/screens/registration_screen.dart';
import 'package:skill_swap/screens/see_all_screen.dart';
import 'package:skill_swap/screens/user_category_screen.dart';
import 'package:skill_swap/state_management/authentication_provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';
import 'package:skill_swap/state_management/user_profile_provider.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';
import 'package:skill_swap/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://lnovunahwnnngzvcuueq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxub3Z1bmFod25ubmd6dmN1dWVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY4MTQyNDgsImV4cCI6MjA1MjM5MDI0OH0.puf3ZDbmlebivma7bcCV228OgRVz-TbP-dwGhm4kcMg',
  );

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => SoftProvider()),
        ChangeNotifierProvider(create: (_) => UserSkillProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      getPages: [
        GetPage(
          name: '/register',
          page: () => const RegistrationScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 800),
        ),
        GetPage(
          name: '/signIn',
          page: () => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 800),
        ),
        GetPage(
          name: '/navigate',
          page: () => Navigation(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/onBoard',
          page: () => const OnboardingScreen(),
          transition: Transition.size,
          transitionDuration: const Duration(milliseconds: 800),
        ),
        GetPage(
          name: '/category',
          page: () => const UserCategoryScreen(),
          transition: Transition.size,
          transitionDuration: const Duration(milliseconds: 800),
        ),
        GetPage(
          name: '/seeAll',
          page: () => const SeeAllScreen(),
          transition: Transition.size,
          transitionDuration: const Duration(milliseconds: 800),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
          transition: Transition.downToUp,
          transitionDuration: const Duration(milliseconds: 800),
        ),
      ],
    );
  }
}
