
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/soft_provider.dart';
import 'package:skill_swap/widgets/form_widget.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<SoftProvider>(context, listen: true);

    const primaryBlue = Color(0xFF2196F3); // Main blue color

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await userDetails.imagePicked();
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: userDetails.imagePath != null
                ? ResizeImage(
                    FileImage(userDetails.imagePath!),
                    width: 160,
                    height: 160,
                  )
                : null,
            backgroundColor: const Color.fromARGB(255, 56, 162, 214),
            child:
                userDetails.imagePath == null ? const Icon(Icons.camera) : null,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'select your profile image',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: primaryBlue, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FormWidget(
            lines: null,
            color: const Color.fromARGB(255, 56, 162, 214),
            hintText: 'First name',
            textController: userDetails.firstname,
            inputWidget: null,
            isObscured: false),
        const SizedBox(
          height: 20,
        ),
        FormWidget(
            color: const Color.fromARGB(255, 56, 162, 214),
            lines: null,
            hintText: 'Last name',
            textController: userDetails.lastname,
            inputWidget: null,
            isObscured: false),
        const SizedBox(
          height: 20,
        ),
        FormWidget(
            color: const Color.fromARGB(255, 56, 162, 214),
            hintText: 'Tell us a bit about you and your skills...',
            textController: userDetails.description,
            lines: 10,
            inputWidget: null,
            isObscured: false),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
