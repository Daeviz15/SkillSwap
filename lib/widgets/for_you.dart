import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForYou extends StatelessWidget {
  const ForYou(
      {super.key,
      required this.you,
      required this.all,
      required this.txtThree,
      required this.seeAll});

  final String you;
  final String all;
  final String txtThree;
  final Function() seeAll;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2196F3); // Main blue color

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  you,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap:seeAll,
                  child: Text(
                    all,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              txtThree,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.w300,
                    fontSize: 11),
              ),
            ),
          ],
        ));
  }
}
