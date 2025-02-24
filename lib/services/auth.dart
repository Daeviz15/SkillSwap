import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skill_swap/screens/navigation.dart';
import 'package:skill_swap/screens/onboarding_screen.dart';
import 'package:skill_swap/screens/user_category_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  Future<bool> _checkFirstTimeSetup(User user) async {
    try {
      // Fetch user document from Firestore
      final doc = await FirebaseFirestore.instance
          .collection('FirstTime')
          .doc(user.uid)
          .get();

      // Return whether the setup is complete or not
      return doc.exists && (doc.data()?['isSetupComplete'] == true);
    } catch (e) {
      print('Error checking first-time setup: $e');
      return false; // Default to showing the UserCategoryScreen on error
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.hasData) {
            return FutureBuilder(
                future: _checkFirstTimeSetup(snapshot.data),
                builder: (ctx, AsyncSnapshot firstTimeSnapshot) {
                  if (firstTimeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    );
                  } else if (firstTimeSnapshot.hasError) {
                    return const Text('error');
                  } else if (firstTimeSnapshot.data == false) {
                    return const UserCategoryScreen();
                  } else {
                    return Navigation();
                  }
                });
          } else {
            return const OnboardingScreen();
          }
        });
  }
}
