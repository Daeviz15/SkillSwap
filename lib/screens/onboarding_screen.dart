import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:skill_swap/widgets/button_widget.dart';
import 'package:skill_swap/widgets/onboarding_circles_widget.dart';
import 'package:skill_swap/widgets/text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 242, 250),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250, child: OnboardingCircles()),
            SvgPicture.asset(
              'assets/app_images/onboard.svg',
              width: 256,
              height: 186.79,
            ),
            const SizedBox(
              height: 50,
            ),
            const TextWidget(
                textOne: 'Learn what you lack, Share what you know',
                textTwo:
                    'Step into a world where learning meets collaboration. Discover what you’re missing, share what makes you unique, and together, let’s build the future of limitless possibilities'),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget(
              text: 'Get Started',
              callback: () {
                Get.toNamed('/register');
              },
            )
          ],
        ),
      ),
    );
  }
}
