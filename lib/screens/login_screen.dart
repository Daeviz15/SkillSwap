import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/services/services.dart';
import 'package:skill_swap/state_management/authentication_provider.dart';
import 'package:skill_swap/widgets/account_creation_text_widget.dart';
import 'package:skill_swap/widgets/app_colors.dart';
import 'package:skill_swap/widgets/button_widget.dart';
import 'package:skill_swap/widgets/form_widget.dart';
import 'package:skill_swap/widgets/onboarding_circles_widget.dart';
import 'package:skill_swap/widgets/text_widget.dart';
import 'package:skill_swap/widgets/tile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void register() {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 210, child: OnboardingCircles()),
            const TextWidget(
                textOne: 'Welcome back! Ready to pick up where you left off?',
                textTwo: ''),
            SvgPicture.asset(
              'assets/app_images/login.svg',
              width: 256,
              height: 186.79,
            ),
            const SizedBox(
              height: 23,
            ),
            FormWidget(
              color: null,
              lines: 1,
              isObscured: false,
              inputWidget: null,
              hintText: 'Enter your email',
              textController: authProvider.email,
            ),
            const SizedBox(
              height: 15,
            ),
            FormWidget(
              color: null,
              lines: 1,
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
              height: 10,
            ),
            Text(
              'Forgot Password?',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            ButtonWidget(
              text: 'Login',
              callback: () {
                authProvider.login(context);
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
                registerOrsignIn: register,
                text: 'Don\'t have an account?',
                textTwo: 'register'),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
