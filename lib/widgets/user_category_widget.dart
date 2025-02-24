import 'package:flutter/material.dart';
import 'package:skill_swap/widgets/options.dart';

class UserCategoryWidget extends StatelessWidget {
  const UserCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {

  

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Options(
          'Web development',
          'Crypto trading',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Options(
              'Video Editing',
              'Animation',
            ),
          ],
        ),
        SizedBox(height: 20),
        Options(
          'Cloud computing',
          'Machine learning',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Options(
              'App development',
              'Forex trading',
            ),
          ],
        ),
        SizedBox(height: 20),
        Options(
          'Graphic design',
          'Content Creation',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Options(
              'Ui/Ux',
              'Digital marketing',
            ),
          ],
        ),
      ],
    );
  }
}
