import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';
import 'package:skill_swap/widgets/app_colors.dart';
import 'package:skill_swap/widgets/for_you.dart';
import 'package:skill_swap/widgets/image_carousel.dart';
import 'package:skill_swap/widgets/load_matched_users.dart';
import 'package:skill_swap/widgets/welcome_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isProfileLoaded = false; // Track if profile data has been loaded

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isProfileLoaded) {
      onRefresh();
      _isProfileLoaded = true;
    }
  }

  Future<void> onRefresh() async {
    try {
      final profile = Provider.of<UserSkillProvider>(context, listen: false);
      await profile.loadUserProfile();
      await profile.matchSkills();
    } catch (e) {
      print('Error during refresh: $e');
      // Optionally show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Subtle cool blue tint
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WelcomeCard(),
              const SizedBox(height: 30),
              const FancyCarousel(),
              const SizedBox(height: 40),
              ForYou(
                seeAll: () {
                  Get.toNamed('/seeAll');
                },
                all: 'See All',
                you: 'Recommended for you',
                txtThree: 'see students with the skills you lack',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45,
                  ),
                  child: const LoadMatchedUsers(),
                ),
              ),
              const SizedBox(height: 50),
              ForYou(
                  seeAll: () {},
                  you: 'Other Skills',
                  all: 'See All',
                  txtThree: 'Other skills you might be interested in'),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
