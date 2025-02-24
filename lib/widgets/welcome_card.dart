import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour == 12 || hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Get user data from provider
    final userProfile = Provider.of<UserSkillProvider>(context);

    // Define colors
    const primaryBlue = Color(0xFF2196F3);
    const lightBlue = Color(0xFFF5F9FF);

    return Container(
      width: screenWidth,
      height: screenHeight * 0.3,
      decoration: const BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display name from provider
                Text(
                  'Hello ${userProfile.firstName ?? "Guest"}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                Container(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications_on,
                    size: 14,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),
            Text(
              getGreetingMessage(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: screenWidth * 0.065,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: primaryBlue,
                            size: 16,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              'Search for coding, graphic design...',
                              style: GoogleFonts.poppins(
                                color: primaryBlue,
                                fontWeight: FontWeight.w300,
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  flex: 1,
                  child: userProfile.profileImage == null
                      ? CircleAvatar(
                          backgroundColor: AppColors.primaryBlue,
                          radius: screenWidth * 0.08,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.toNamed('/profile');
                          },
                          child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 114, 201, 255),

                            backgroundImage: ResizeImage(
                              width: 156,
                              height: 115,
                              NetworkImage(userProfile.profileImage!),
                            ),
                            radius: screenWidth * 0.08,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
