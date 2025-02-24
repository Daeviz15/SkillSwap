import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class StepButtonWidget extends StatelessWidget {
  const StepButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final softProvider = Provider.of<SoftProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (softProvider.currentStep < 3) {
                softProvider.incrementStep();
              } else {
                softProvider.proceed(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                softProvider.currentStep < 3 ? 'Next' : 'Finish',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            onPressed: softProvider.currentStep > 1
                ? () {
                    softProvider.decrementStep();
                  }
                : () {
                    Get.offAllNamed('/navigate'); // Delegate navigation
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Text(
                softProvider.currentStep > 1 ? 'Previous' : 'Skip',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
