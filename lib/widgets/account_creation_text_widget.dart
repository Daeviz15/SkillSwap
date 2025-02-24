import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountCreationTextWidget extends StatelessWidget {
  const AccountCreationTextWidget(
      {super.key, required this.text, required this.textTwo, required this.registerOrsignIn});
  final String text;
  final String textTwo;
 final  void Function  () registerOrsignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w300),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: registerOrsignIn,
          child: Text(
            textTwo,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 13,
                  color:Color.fromARGB(235, 67, 150, 192),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
