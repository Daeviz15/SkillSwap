import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.textOne, required this.textTwo});

  final String textOne;
  final String textTwo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textOne,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 14, color:  Color.fromARGB(236, 88, 155, 188), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            textTwo,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 160, 154, 154),
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
