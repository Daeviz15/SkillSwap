import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, required this.callback});
  final String text;
  final void Function() callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
                  color: AppColors.primaryBlue,

        padding: const EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
