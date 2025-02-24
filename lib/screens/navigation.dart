import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/screens/chat_screen.dart';
import 'package:skill_swap/screens/home_screen.dart';
import 'package:skill_swap/screens/profile_screen.dart';
import 'package:skill_swap/screens/schedule_screen.dart';
import 'package:skill_swap/state_management/soft_provider.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class Navigation extends StatelessWidget {
  Navigation({super.key});

  final List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const ScheduleScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2196F3); // Main blue color

    final softProvider = Provider.of<SoftProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              primaryBlue,
              Color(0xFF5DACDE),
              Color.fromARGB(255, 9, 97, 169),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(.4),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: GNav(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 600),
          selectedIndex: softProvider.selectedTab,
          onTabChange: (value) {
            softProvider.select(value);
          },
          gap: 10,
          backgroundColor: Colors.transparent,
          activeColor: Colors.white,
          color: Colors.white.withOpacity(0.7),
          padding: const EdgeInsets.all(12),
          tabBackgroundColor:
              const Color.fromARGB(255, 9, 71, 109).withOpacity(0.2),
          rippleColor: Colors.blue.withOpacity(0.3), // Ripple effect color
          haptic: true, // Haptic feedback on tab change
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            GButton(
              icon: Icons.home_rounded,
              text: 'Home',
              iconSize: 28,
            ),
            GButton(
              icon: Icons.chat_bubble_rounded,
              text: 'Chat',
              iconSize: 28,
            ),
            GButton(
              icon: Icons.schedule_rounded,
              text: 'Schedule',
              iconSize: 28,
            ),
            GButton(
              icon: Icons.person_rounded,
              text: 'Profile',
              iconSize: 28,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: softProvider.selectedTab,
        children: screens,
      ),
    );
  }
}
