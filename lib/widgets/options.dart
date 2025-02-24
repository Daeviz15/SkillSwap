import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';

class Options extends StatelessWidget {
  const Options(
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
            softProvider.setTapped(label, !softProvider.onTap(label));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 40),
            decoration: BoxDecoration(
              border: softProvider.onTap(label)
                  ? null
                  : Border.all(color: const Color(0xFF5DACDE)),
              borderRadius: BorderRadius.circular(25),
              color: softProvider.onTap(label)
                  ? const Color(0xFF5DACDE)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: softProvider.onTap(label)
                        ? Colors.white
                        : const Color(0xFF5DACDE),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
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
            softProvider.setTapped(labelTwo, !softProvider.onTap(labelTwo));
          },
          child: Container(
            decoration: BoxDecoration(
              border: softProvider.onTap(labelTwo)
                  ? null
                  : Border.all(color: const Color(0xFF5DACDE)),
              borderRadius: BorderRadius.circular(25),
              color: softProvider.onTap(labelTwo)
                  ? const Color(0xFF5DACDE)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                labelTwo,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: softProvider.onTap(labelTwo)
                        ? Colors.white
                        : const Color(0xFF5DACDE),
                    fontWeight: FontWeight.w700,
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
