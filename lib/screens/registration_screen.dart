import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/services/services.dart';
import 'package:skill_swap/state_management/authentication_provider.dart';
import 'package:skill_swap/widgets/account_creation_text_widget.dart';
import 'package:skill_swap/widgets/button_widget.dart';
import 'package:skill_swap/widgets/form_widget.dart';
import 'package:skill_swap/widgets/onboarding_circles_widget.dart';
import 'package:skill_swap/widgets/text_widget.dart';
import 'package:skill_swap/widgets/tile.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  void signIn() {
    Get.toNamed('/signIn');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 237, 251),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200, child: OnboardingCircles()),
            SvgPicture.asset(
              'assets/app_images/team.svg',
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 15,
            ),
            const TextWidget(
                textOne: 'Excited to see you! Let\'s refine your skills',
                textTwo: 'Let\'s help you refine your skill'),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 15,
            ),
            FormWidget(
              lines: 1,
              color: null,
              isObscured: false,
              inputWidget: null,
              hintText: 'Enter your email',
              textController: authProvider.email,
            ),
            const SizedBox(
              height: 15,
            ),
            FormWidget(
              lines: 1,
              color: null,
              isObscured: !authProvider.showIcon,
              inputWidget: IconButton(
                  onPressed: () {
                    authProvider.togglePasswordVisibility();
                  },
                  icon: authProvider.showIcon
                      ? const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 90, 176, 219),
                          size: 20.0,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 90, 176, 219),
                          size: 20.0,
                        )),
              hintText: 'Enter your password',
              textController: authProvider.password,
            ),
            const SizedBox(
              height: 15,
            ),
            FormWidget(
              lines: 1,
              color: null,
              isObscured: authProvider.showIcon ? false : true,
              inputWidget: IconButton(
                  onPressed: () {
                    authProvider.togglePasswordVisibility();
                  },
                  icon: authProvider.showIcon
                      ? const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 90, 176, 219),
                          size: 20.0,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 90, 176, 219),
                          size: 20.0,
                        )),
              hintText: 'Confirm password',
              textController: authProvider.confirmPassword,
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              text: 'Register',
              callback: () {
                authProvider.register(context);
              },
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tile(
                  onAuthenticate: () {
                    Services().signInWithGoogle();
                  },
                  asset: 'assets/app_images/google-logo.png',
                ),
                const SizedBox(
                  width: 10,
                ),
                Tile(
                    onAuthenticate: () {},
                    asset: 'assets/app_images/app-logo.png')
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            AccountCreationTextWidget(
              registerOrsignIn: signIn,
              text: 'Already have an account?',
              textTwo: 'sign in',
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
