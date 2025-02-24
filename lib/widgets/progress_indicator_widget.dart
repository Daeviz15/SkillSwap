import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final softProvider = Provider.of<SoftProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${softProvider.currentStep} of 2',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF5DACDE),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: softProvider.currentStep == 1 ? 0.3 : softProvider.currentStep ==2 ? 0.65 : 1.0,
            color: Colors.blue,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
