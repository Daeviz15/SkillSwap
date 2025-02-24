import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/screens/user_details_screen.dart';
import 'package:skill_swap/state_management/soft_provider.dart';
import 'package:skill_swap/widgets/onboarding_circles_widget.dart';
import 'package:skill_swap/widgets/progress_indicator_widget.dart';
import 'package:skill_swap/widgets/second_category.dart';
import 'package:skill_swap/widgets/step_button_widget.dart';
import 'package:skill_swap/widgets/text_widget.dart';
import 'package:skill_swap/widgets/user_category_widget.dart';

class UserCategoryScreen extends StatelessWidget {
  const UserCategoryScreen({super.key});

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return const TextWidget(
          textOne: 'What skills do you want to learn?',
          textTwo: 'Let\'s help you find a tutor',
        );
      case 2:
        return const TextWidget(
          textOne: 'What skills do you have to give?',
          textTwo: 'Let\'s help you swap your skill',
        );
      case 3:
        return const TextWidget(
          textOne: 'Complete Your Profile',
          textTwo: 'Tell us more about yourself',
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStepWidget(int step, BuildContext context) {
    switch (step) {
      case 1:
        return SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const UserCategoryWidget()));
      case 2:
        return SingleChildScrollView(
          child: SizedBox(
                  height: MediaQuery.of(context).size.height,
            
            child: const SecondCategoryWidget()),
        );
      case 3:
        return const SingleChildScrollView(child: UserDetailsScreen());
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final softProvider = Provider.of<SoftProvider>(context, listen: true);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 237, 251),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 190, child: OnboardingCircles()),
            if (softProvider.currentStep < 3) ...[
              SvgPicture.asset(
                softProvider.currentStep == 2
                    ? 'assets/app_images/teach.svg'
                    : 'assets/app_images/learn.svg',
                height: 70,
                width: 70,
              ),
              const SizedBox(height: 20),
            ],
            _buildStepContent(softProvider.currentStep),
            const SizedBox(height: 40),
            SizedBox(
              width: screenWidth * 0.8,
              height: 405,
              child: _buildStepWidget(softProvider.currentStep, context),
            ),
            const ProgressIndicatorWidget(),
            const SizedBox(height: 10),
            const StepButtonWidget(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
