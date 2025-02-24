import 'package:flutter/material.dart';
import 'package:skill_swap/widgets/options_two.dart';

class SecondCategoryWidget extends StatelessWidget {
  const SecondCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OptionsTwo(
          'Cloud computing',
          'Machine learning',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OptionsTwo(
              'App development',
              'Forex trading',
            ),
          ],
        ),
        SizedBox(height: 20),
        OptionsTwo(
          'Web development',
          'Crypto trading',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OptionsTwo(
              'Video Editing',
              'Animation',
            ),
          ],
        ),
        SizedBox(height: 20),
        OptionsTwo(
          'Ui/Ux',
          'Digital marketing',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OptionsTwo(
              'Graphic design',
              'Content Creation',
            ),
          ],
        ),
      ],
    );
  }
}
