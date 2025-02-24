import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/screens/user_category_screen.dart';
import 'package:skill_swap/state_management/authentication_provider.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!.email;

  Future<bool> firstTime() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final firstTimeDetails =
        await FirebaseFirestore.instance.collection('FirstTime').doc(id).get();

    final data = firstTimeDetails.data();
    if (data != null && data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearText(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.email.clear();
    authProvider.password.clear();
    authProvider.confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2196F3);

    final skillProvider =
        Provider.of<UserSkillProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout')),
        ],
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: AppColors.primaryBlue,
          ),
        ),
        forceMaterialTransparency: true,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: firstTime(),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: primaryBlue,
                  size: 50.0,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading profile, please refresh',
                  style: GoogleFonts.poppins(color: primaryBlue),
                ),
              );
            }

            if (snapshot.hasData && snapshot.data != null) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Stack(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(skillProvider.profileImage!),
                        radius: screenWidth * 0.10,
                      ),
                      const Positioned(
                          bottom: 0,
                          right: 3,
                          child: Icon(
                            Icons.camera,
                            size: 22,
                            color: Colors.blue,
                          ))
                    ]),
                    const SizedBox(height: 15),
                    Text(
                      ' ${skillProvider.firstName ?? "Guest"}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: primaryBlue,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your skills ',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: primaryBlue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skills you want to learn',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: primaryBlue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const UserCategoryScreen();
            }
          },
        ),
      ),
    );
  }
}
