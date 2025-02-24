import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Scheduler'),
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
