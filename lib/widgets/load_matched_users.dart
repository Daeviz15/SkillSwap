import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/screens/matched_user_profile.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';
import 'dart:math';

class LoadMatchedUsers extends StatelessWidget {
  const LoadMatchedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    // Define consistent colors
    const primaryBlue = Color(0xFF2196F3); // Main blue color
    const lightBlue = Color(0xFFF5F9FF); // Light blue background

    final skillsProvider =
        Provider.of<UserSkillProvider>(context, listen: false);

    return FutureBuilder(
      future: skillsProvider.matchSkills(),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitFadingCircle(
              color: primaryBlue,
              size: 50.0,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading matched users',
              style: GoogleFonts.poppins(color: primaryBlue),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'please complete your profile to see recommended skills',
              style: GoogleFonts.poppins(color: primaryBlue),
            ),
          );
        }

        final List snapCount = snapshot.data ?? [];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: min(snapCount.length, 3),
          itemBuilder: (ctx, int index) {
            final snapDataIndex = snapCount[index];
            final matchedSkills =
                (snapDataIndex['matchingSkills'] as List).take(3).toList();
            final allSkills = (snapDataIndex['allSkills'] as List).toList();

            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  CircleAvatar(
                      radius: 28,
                      backgroundImage: ResizeImage(
                        width: 156,
                        height: 120,
                        NetworkImage(snapDataIndex['Profile_Image']),
                      )),
                  const SizedBox(height: 6),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 200,
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          snapDataIndex['FirstName'] +
                                  ' ' +
                                  snapDataIndex['LastName'] ??
                              'Unknown User',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Matched skills',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            textAlign: TextAlign.center,
                            matchedSkills.join(', '),
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        color: lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          textAlign: TextAlign.center,
                                          snapDataIndex['FirstName'] +
                                                  ' ' +
                                                  snapDataIndex['LastName'] ??
                                              'This user hasn\'t told us his name yet😀',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: primaryBlue,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'This user has ${allSkills.length} skills:',
                                          style: GoogleFonts.poppins(
                                              color: primaryBlue),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            allSkills.join(', '),
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: primaryBlue,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 5),
                              child: Text(
                                'see all',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 8),
                                child: Row(children: [
                                  Text(
                                    'chat',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: primaryBlue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.chat,
                                    color: primaryBlue,
                                    size: 14.0,
                                  ),
                                ]),
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return MatchedUserProfile(
                                  matchedUserId: snapDataIndex['uid'],
                                );
                              }));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Row(children: [
                                    Text(
                                      'view profile',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.person_3_rounded,
                                      color: primaryBlue,
                                      size: 14.0,
                                    ),
                                  ]),
                                )),
                          ),
                        ]),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
