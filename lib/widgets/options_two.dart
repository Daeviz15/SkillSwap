import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';

class OptionsTwo extends StatelessWidget {
  const OptionsTwo(
    this.label,
    this.labelTwo, {
    super.key,
  });
  final String label;
  final String labelTwo;

  @override
  Widget build(BuildContext context) {
    final softProvider = Provider.of<SoftProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First option
        GestureDetector(
          onTap: () {
            softProvider.setTappedTwo(label, !softProvider.onTapTwo(label));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 40),
            decoration: BoxDecoration(
              border: softProvider.onTapTwo(label)
                  ? null
                  : Border.all(color: const Color(0xFF5DACDE)),
              borderRadius: BorderRadius.circular(25),
              color: softProvider.onTapTwo(label)
                  ? const Color(0xFF5DACDE)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: softProvider.onTapTwo(label)
                        ? Colors.white
                        : const Color(0xFF5DACDE),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Second option
        GestureDetector(
          onTap: () {
            softProvider.setTappedTwo(
                labelTwo, !softProvider.onTapTwo(labelTwo));
          },
          child: Container(
            decoration: BoxDecoration(
              border: softProvider.onTapTwo(labelTwo)
                  ? null
                  : Border.all(color: const Color(0xFF5DACDE)),
              borderRadius: BorderRadius.circular(25),
              color: softProvider.onTapTwo(labelTwo)
                  ? const Color(0xFF5DACDE)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                labelTwo,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: softProvider.onTapTwo(labelTwo)
                        ? Colors.white
                        : const Color(0xFF5DACDE),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
