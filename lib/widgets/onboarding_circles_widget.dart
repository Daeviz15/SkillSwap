import 'package:flutter/material.dart';

class OnboardingCircles extends StatelessWidget {
  const OnboardingCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue Circle 1
        Positioned(
          top: -10,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color.fromARGB(143, 114, 195, 246),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Blue Circle 2
        Positioned(
          top: -55,
          right: 130,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Color.fromARGB(143, 114, 195, 246),

              shape: BoxShape.circle,
            ),
          ),
        ),
        // Main Content
      ],
    );
  }
}
