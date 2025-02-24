import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.hintText,
    required this.textController,
    required this.inputWidget,
    required this.isObscured,
    required this.lines,
    required this.color,
  });
  final String hintText;
  final TextEditingController textController;
  final Widget? inputWidget;
  final int? lines;
  final Color? color;
  final bool isObscured;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: TextFormField(
        obscureText: isObscured,
        maxLines: lines,
        controller: textController,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 56, 162, 214),
        )),
        decoration: InputDecoration(
            suffixIcon: inputWidget,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 14,
                  color: color ?? Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
